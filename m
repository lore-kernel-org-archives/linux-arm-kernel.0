From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 19 Nov 2014 00:16:27 +0000
Subject: [PATCH 08/25] ARM: shmobile: r8a7790: sound enables Audio DMAC
 peri peri entry on DTSI
In-Reply-To: <15076656.0HaaBPou9k@wuerfel>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
 <1877842.49FtTfL2eK@wuerfel>
 <87a93pxtlr.wl%kuninori.morimoto.gx@renesas.com>
 <15076656.0HaaBPou9k@wuerfel>
Message-ID: <871tp09h9g.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd

> > This device has 10 sound channels, and using 3 kind of IPs.
> > Then, data input/output needs DMA channel which needs specific ID to using.
> > Above name has ID pair for it, so there is much combination. 
> > These specific ID is based on SoC, not board.
> > Sound driver / DMAEngine can get specific ID from above.
> > 
> > Indeed binding itself was not documented yet.
> > I will add it ASAP.
> 
> It sounds like you have some device-to-device DMAs here, which isn't
> supported by the generic dmaengine binding at all, and I don't think
> the driver currently attempts to use them.
> 
> Is that correct? Could you try to remove those from the binding and
> just leave the device-to-memory and memory-to-device channels there?
> If we ever want to support those, we probably have to extend the
> dmaengine binding first, and then the driver binding would also look
> different.

It depends sound data path. basically, sound data goes memory-to-device
or device-to-memory. but, it needs special IP if you want to use special effect.
In such case, sound data path will be memory-to-device-to-device, or device-to-device-to-memory.
This path based on board, and, our reference board is using above path.
