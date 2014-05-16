From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 16 May 2014 13:46:52 -0300
Subject: USB with 3.14.3 not working on Freescale i.mx6
In-Reply-To: <1400257863.657063826@f426.i.mail.ru>
References: <CACWLcfv6akXuM59m_hX-xB=iQYA4iAx7fZ0T5ZB3-7ik-1GZMw@mail.gmail.com>
 <CAOMZO5DzLBWFnOMCsz7W1DHg7g0CnZn2bxwjF6H6XVgMYmw-BQ@mail.gmail.com>
 <1400257863.657063826@f426.i.mail.ru>
Message-ID: <CAOMZO5DKqJFK3KB8Qgjdzk4OKCPDO3cCkQMVKJkTjC91+WQaoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 1:31 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> Fri, 16 May 2014 13:20:29 -0300 ?? Fabio Estevam <festevam@gmail.com>:
>> On Wed, May 14, 2014 at 6:17 AM, Till Klocke <till.klocke@yetu.com> wrote:
>> > Hello,
>> >
>> > Currently I am trying to get a recent and stable Linux kernel running
>> > on a Phytec PhyFlex board based on the i.mx6 processor from Freescale.
>>
>> Which dts file do you use?
>>
>> USB is functional on other mx6 boards.
>
> It's just words. Fabio, just give portion of the log (if it possible) where we
> see that USB is works with this kernel version and similar hardware.

On a imx6q-wandboard:

fec 2188000.ethernet eth0: Freescale FEC PHY driver [Atheros 8031 ethernet] (mi)
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
scsi 1:0:0:0: Direct-Access     Ut163    USB2FlashStorage 0.00 PQ: 0 ANSI: 2
sd 1:0:0:0: [sda] 248000 512-byte logical blocks: (126 MB/121 MiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Asking for cache data failed
sd 1:0:0:0: [sda] Assuming drive cache: write through
 sda: sda1
sd 1:0:0:0: [sda] Attached SCSI removable disk
...

root at freescale /$ uname -r
3.15.0-rc5
root at freescale /$ lsusb
Bus 001 Device 002: ID 0457:0151
Bus 001 Device 001: ID 1d6b:0002

Haven't tried 3.14 though. Is it broken on 3.14? Can you try 3.15-rc5
to compare?
