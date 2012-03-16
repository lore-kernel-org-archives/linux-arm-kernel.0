From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 11:53:05 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F62B729.2090902@freescale.com>
References: <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
 <4F62A06C.5000304@freescale.com>
 <20120316022345.GA7632@S2101-09.ap.freescale.net>
 <4F62B729.2090902@freescale.com>
Message-ID: <20120316035254.GF6065@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 03:44:43AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> >> >
> > Something like "fsl-pcm-audio", but different from "fsl-pcm-audio"
> > will be instantiated as a hardware block by device tree,
> > "imx-pcm-audio" is pretty much like a ASoC wrapper for calling
> > dmaengine driver.  So there is no hardware block presenting this
> > "device" in device tree, and we need to instantiate it from cpu DAI
> > driver as Mark suggested.
> 
> Wait, is this the DMA controller?  Because on PowerPC, we have device tree 
> nodes for the DMA controller.  Why don't you have one on i.MX?
> 
We do have a DMA controller node for IMX.

	sdma at 83fb0000 {
		compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
		reg = <0x83fb0000 0x4000>;
		interrupts = <6>;
	};

But it's instantiated as a dmaengine device backed by dmaengine driver
drivers/dma/imx-dma.c.  "imx-pcm-audio" will just be an ASoC dmaengine
client using dmaengine API.

-- 
Regards,
Shawn
