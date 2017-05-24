From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 24 May 2017 16:14:04 +0530
Subject: [PATCH v3 0/9] Add support for the audio codec on Allwinner V3s
In-Reply-To: <20170524104008.GA15061@localhost>
References: <20170524100607.29790-1-icenowy@aosc.io>
 <20170524104008.GA15061@localhost>
Message-ID: <20170524104404.GB15061@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed Arnd email now..

On Wed, May 24, 2017 at 04:10:08PM +0530, Vinod Koul wrote:
> On Wed, May 24, 2017 at 06:05:58PM +0800, Icenowy Zheng wrote:
> > Allwinner V3s features a audio codec with dedicated digital and analog parts,
> > like the ones on A23/H3, but much simpler (lack of MIC2, LINE IN and MBIAS).
> > 
> > Add support for it.
> > 
> > In order to make the codec usable, DMA support is also added in this series.
> > 
> > Patch 1 split out MBIAS in analog codec driver.
> > 
> > Patch 2 prepared a set of objects that have MIC2 and LINEIN stripped out
> > for V3s.
> > 
> > Patch 3/4 adds support for V3s in analog/digital codec.
> > 
> > Patch 5 add the gate bit as a common quirk of sun6i-dma driver, as V3s also
> > needs it.
> > 
> > Patch 6 really adds support for V3s in DMA engine.
> > 
> > Patch 7/8/9 adds three parts of device tree: DMA engine, codec support
> > and enable the codec for Lichee Pi Zero dock.
> > 
> > Icenowy Zheng (9):
> >   ASoC: sun8i-codec-analog: split out mbias
> >   ASoC: sun8i-codec-analog: prepare a mixer control/widget/route set for
> >     V3s
> >   ASoC: sun8i-codec-analog: add support for V3s SoC
> >   ASoC: sun4i-codec: Add support for V3s codec
> >   dmaengine: sun6i: make gate bit in sun8i's DMA engines a common quirk
> >   dmaengine: sun6i: support V3s SoC variant
> >   ARM: dts: sun8i: add DMA engine in V3s DTSI
> >   ARM: dts: sun8i: add audio codec support into V3s DTSI
> >   ARM: sun8i: v3s: enable audio on Lichee Pi Zero Dock board
> 
> And why do we need the cross tree submission?? I have asked before and was
> met with silence! [1]
> 
> Can you please split it up per subsystem to make it easy for everyone and
> clearly spell out dependencies.
> 
> [1]: https://www.spinics.net/lists/dmaengine/msg12884.html

-- 
~Vinod
