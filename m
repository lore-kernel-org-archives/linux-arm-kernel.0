From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 7 Nov 2012 20:42:10 +0800
Subject: [PATCH 3/3] dmaengine: sirf: enable the driver support new
 SiRFmarco SoC
In-Reply-To: <CAGsJ_4y=sccFizQfwO-mx5GcvkgR9nWqksmuwrvSYpL+N5U1wg@mail.gmail.com>
References: <1348734996-20086-1-git-send-email-Barry.Song@csr.com>
 <1351076581.5263.56.camel@vkoul-udesk3>
 <CAGsJ_4yY6YYKb+g4k7BcL_SyyBN9xYCwxRLX6rN5_afroK0e_g@mail.gmail.com>
 <1351138901.5263.70.camel@vkoul-udesk3>
 <CAGsJ_4y=sccFizQfwO-mx5GcvkgR9nWqksmuwrvSYpL+N5U1wg@mail.gmail.com>
Message-ID: <CAGsJ_4wZ0cCP+aPYeEDXhDBF-vQPtHD1u53SpGNGV6AFXHMygg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/25 Barry Song <21cnbao@gmail.com>
>
> 2012/10/25 Vinod Koul <vkoul@infradead.org>:
> > On Wed, 2012-10-24 at 19:59 +0800, Barry Song wrote:
> >> Hi Vinod,
> >> Thanks a lot!
> > Please dont top post.
>
> well. saying hello is an exception :-)
>
> >>
> >> 2012/10/24 Vinod Koul <vkoul@infradead.org>
> >> >
> >> > On Thu, 2012-09-27 at 16:36 +0800, Barry Song wrote:
> >> > > From: Barry Song <Baohua.Song@csr.com>
> >> > >
> >> > > The driver supports old up SiRFprimaII SoCs, this patch makes it
> >> > > support
> >> > > the new SiRFmarco as well.
> >> > > SiRFmarco, as a SMP SoC, adds new DMA_INT_EN_CLR and
> >> > > DMA_CH_LOOP_CTRL_CLR
> >> > > registers, to disable IRQ/Channel, we should write 1 to the
> >> > > corresponding
> >> > > bit in the two CLEAR register.
> >> > >
> >> > > Tested on SiRFmarco using SPI driver:
> >> > >     $ /mnt/spidev-sirftest -D /dev/spidev32766.0
> >> > >     spi mode: 0
> >> > >     bits per word: 8
> >> > >     max speed: 500000 Hz (500 KHz)
> >> > >
> >> > >     00 00 00 00 00 00
> >> > >     00 00 00 00 00 00
> >> > >     00 00 00 00 00 00
> >> > >     00 00 00 00 00 00
> >> > >     00 00 00 00 00 00
> >> > >     00 00 00 00 00 00
> >> > >     00 00 00 00
> >> > >
> >> > >     $ cat /proc/interrupts
> >> > >                CPU0       CPU1
> >> > >      32:       1593          0       GIC  sirfsoc_timer0
> >> > >      33:          0       3533       GIC  sirfsoc_timer1
> >> > >      44:          0          0       GIC  sirfsoc_dma
> >> > >      45:         16          0       GIC  sirfsoc_dma
> >> > >      47:          6          0       GIC  sirfsoc_spi
> >> > >      50:       5654          0       GIC  sirfsoc-uart
> >> > >      ...
> >> > >
> >> > > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> >> > > ---
> > I tried applying this and it failed for me. Can you please respin this
> > on my next and send again.

done. at:
http://www.spinics.net/lists/arm-kernel/msg204504.html

> >
> > --
> > Vinod Koul
> > Intel Corp.
>
> -barry
