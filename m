From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 9 Apr 2012 12:21:08 +0530
Subject: spi-s3c64xx: problems with SPI_MODE_3 transfers
In-Reply-To: <201204082039.34325.heiko@sntech.de>
References: <201204082039.34325.heiko@sntech.de>
Message-ID: <CABb+yY3_YAk_V5ZVJ1ntKEhvsL4BcC+YSnu_-6v=dHCMZ6ZmHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2012 at 12:09 AM, Heiko St?bner <heiko@sntech.de> wrote:
> [@jassi: I know that you do not work at this stuff any longer, but I included
> you in the list of recipients in the hope that you might be able to give me a
> pointer on where to look for the culprit of the problem :-) ]
>
>
> Hi,
>
> while working on the beginnings of a wireless driver connected via SPI [1],
> the s3c64xx-spi-driver produced strange problems while doing MODE_3 ?(CPOL |
> CPHA) transfers: [2]
>
> [write] spi cur_bpw: 8: ?0x00 0x00 0x04 0x00
> [read] ?spi cur_bpw: 8: ?0x00 0x00 0x00 0x00
> [read] ?spi cur_bpw: 8: ?0x00 0x00 0x00 0x00
> (chip_id = 0x0000, chip_rev = 0x00)
> mapped channel 24 to 0
> mapped channel 23 to 1
> [write] spi cur_bpw: 8: ?0x00 0x00 0x04 0x00
> [read] ?spi cur_bpw: 8: ?0x00 0x00 0x00 0x00
> [read] ?spi cur_bpw: 8: ?0x00 0x00 0x00 0x00
> CIR: 0
> [write] spi cur_bpw: 8: ?0x00 0x00 0x04 0x00
> [read] ?spi cur_bpw: 8: ?0x00 0x00 0x00 0x00
> mt592x_spi spi0.0: I/O Error: rx-1 tx-0 res:rx-f tx-p len-4
> CIR: 0
> [write] spi cur_bpw: 8: ?0x00 0x00 0x04 0x00
> mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
> CIR: 0
> [write] spi cur_bpw: 8: ?0x00 0x00 0x04 0x00
> mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
> CIR: 0
> [write] spi cur_bpw: 8: ?0x00 0x00 0x04 0x00
> mt592x_spi spi0.0: I/O Error: rx-0 tx-1 res:rx-p tx-f len-4
> CIR: 0
>
> where the expected result would be:
>
> [write] spi cur_bpw: 8: ?0x00 0x00 0x04 0x00
> [read] ?spi cur_bpw: 8: ?0x00 0x00 0x00 0x00
> [read] ?spi cur_bpw: 8: ?0x21 0x59 0x91 0x00
>
> The pattern of either empty results or read errors also varies with each
> invocation, i.e. sometimes all fail or all result in wrong values and so on.
>
>
> In contrast when doing this with the spi-gpio driver, everything works as
> expected and I get the expected results.
>
> Also the device-family I'm working on contains a variant with a Marvell 8686
> wlan chip [= the rest of the system is the same]. Using the spi-s3c64xx with
> the libertas driver (MODE_0) works as expected.
>
>
> As I'm not sure where I should look for errors in the driver, I would be glad
> to get pointers in the right direction.
>
You might want to play around tuning the 'fb_delay' and maybe signal
strength too.

-j
