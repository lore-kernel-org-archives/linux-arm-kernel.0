From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 17 Jan 2010 10:00:10 +0800
Subject: s3c-hsotg driver problem
In-Reply-To: <4B51B36C.6040308@gmail.com>
References: <4B51B36C.6040308@gmail.com>
Message-ID: <3c17e3571001161800m14ca30cas1cca155f9880513d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In fact, I once used 12Mhz  external crystal, after setting PHYCLK
right,  both USB 1.1 as host and 2.0 as gadget can work. The kernel
version I used is 2.6.28.

On Sat, Jan 16, 2010 at 8:39 PM, Maurus Cuelenaere
<mcuelenaere@gmail.com> wrote:
> Hi,
>
> I'm trying to get the USB OTG port working on my device (S3C6410 board), but
> am running into problems.
> This board doesn't have a 48Mhz clock, so I set the reference clock in the
> USB PLL to a 12Mhz external crystal (see patch).
>
> Still, I'm having trouble getting it to work; I'm seeing these messages (see
> attachment for full log):
>
> s3c-hsotg s3c-hsotg: s3c_hsotg_rx_data: FIFO 8 bytes on ep0 but no req
> (DxEPCTl=0x00028000)
> hub 1-0:1.0: connect-debounce failed, port 2 disabled
>
> This looks like the hardware is configured correctly, but the
> currently-in-use gadget isn't setting up an EP0 RX transfer?
> I've tried Mass Storage, serial, Ethernet, ... gadgets and they all give the
> same errors.
>
> Any hints/pointers would be welcome!
>
> Thanks,
> Maurus Cuelenaere
>
