From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 12:14:33 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F62BCBE.7030806@freescale.com>
References: <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
 <4F62A06C.5000304@freescale.com>
 <20120316022345.GA7632@S2101-09.ap.freescale.net>
 <4F62B729.2090902@freescale.com>
 <20120316035254.GF6065@S2101-09.ap.freescale.net>
 <4F62BCBE.7030806@freescale.com>
Message-ID: <20120316041428.GA7772@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 04:08:32AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > But it's instantiated as a dmaengine device backed by dmaengine driver
> > drivers/dma/imx-dma.c.  "imx-pcm-audio" will just be an ASoC dmaengine
> > client using dmaengine API.
> 
> So you don't have the equivalent of sound/soc/fsl_dma.c?  Don't you need 
> to program the DMA controller specifically for audio?  There's no way I 
> could use drivers/dma/fsldma.c for audio.
> 
I need to program the DMA controller for audio.  But that's done through
generic dmaengine API with audio specific parameters passed in.  That's
pretty much what all snd_imx_pcm_hw_params (sound/soc/fsl/imx-pcm-dma.c)
does there.

-- 
Regards,
Shawn
