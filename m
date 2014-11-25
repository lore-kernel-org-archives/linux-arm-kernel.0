From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 25 Nov 2014 00:59:40 +0000
Subject: [PATCH 08/25] ARM: shmobile: r8a7790: sound enables Audio DMAC
 peri peri entry on DTSI
In-Reply-To: <15076656.0HaaBPou9k@wuerfel>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
 <1877842.49FtTfL2eK@wuerfel>
 <87a93pxtlr.wl%kuninori.morimoto.gx@renesas.com>
 <15076656.0HaaBPou9k@wuerfel>
Message-ID: <87mw7gumbj.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd

> > > >                                 "mem_src6",     "src6_mem",
> > > >                                 "mem_src7",     "src7_mem",
> > > >                                 "mem_src8",     "src8_mem",
> > > > -                               "mem_src9",     "src9_mem";
> > > > +                               "mem_src9",     "src9_mem",
> > > > +
> > > > +                               "src0_ssiu0",           "src1_ssiu0",           "src2_ssiu0",           "src3_ssiu0",           "src4_ssiu0",
> > > > +                               "src0_ssiu1",           "src1_ssiu1",           "src2_ssiu1",           "src3_ssiu1",           "src4_ssiu1",
> > > > +                               "src0_ssiu2",           "src1_ssiu2",           "src2_ssiu2",           "src3_ssiu2",           "src4_ssiu2",
(snip)
> It sounds like you have some device-to-device DMAs here, which isn't
> supported by the generic dmaengine binding at all, and I don't think
> the driver currently attempts to use them.
> 
> Is that correct? Could you try to remove those from the binding and
> just leave the device-to-memory and memory-to-device channels there?
> If we ever want to support those, we probably have to extend the
> dmaengine binding first, and then the driver binding would also look
> different.

Indeed it is needed for device-to-device DMA transfer,
but, it is using generic dmaengine style.
(see linux/sound/soc/sh/rcar/core.c, linux/drivers/dma/sh/rcar-audmapp.c)
If I exchange dmaengine binding style for device-to-device,
I need to change both dmaengine driver and sound driver.
But, I want to know why I should do it ?
Indeed it needs many DMA binding entries now, but, it is using normal dmaengine bindings.
