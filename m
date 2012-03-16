From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 10:23:47 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F62A06C.5000304@freescale.com>
References: <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
 <4F62A06C.5000304@freescale.com>
Message-ID: <20120316022345.GA7632@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 02:07:42AM +0000, Tabi Timur-B04825 wrote:
...
> >> +		ssi_private->imx_pcm_pdev =
> >> +			platform_device_register_simple("imx-pcm-audio",
> >>
> > This is still IMX vs. PowerPC thing rather than "old binding" vs. "new
> > binding" one.
> 
> What is "imx-pcm-audio"?
> 
Something like "fsl-pcm-audio", but different from "fsl-pcm-audio"
will be instantiated as a hardware block by device tree,
"imx-pcm-audio" is pretty much like a ASoC wrapper for calling
dmaengine driver.  So there is no hardware block presenting this
"device" in device tree, and we need to instantiate it from cpu DAI
driver as Mark suggested.

-- 
Regards,
Shawn
