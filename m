From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 10:01:14 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F621C60.5090700@freescale.com>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
Message-ID: <20120316020111.GE6065@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 11:44:16AM -0500, Timur Tabi wrote:
...
> Ok, fair enough.  I understand that my binding has no way of specifying
> board-specific properties, or anything that isn't directly related to the
> SSI, codec, or DMA controller.
> 
> However, I don't like the way this is being represented as a PowerPC vs.
> ARM issue, because that's just not correct.  It's an "old binding" vs "new
> binding" issue.  For example:
> 
> +	/*
> +	 * In case of imx, the machine driver uses new binding which does
> +	 * not require SSI driver to trigger machine driver's probe, but
> +	 * the pcm device needs to be registered here.
> +	 */
> +	if (ssi_private->ssi_on_imx) {

This could probably change to check whether property codec-handle is
present under SSI node to decide if it runs with "old binding" or
"new binding".

> +		ssi_private->imx_pcm_pdev =
> +			platform_device_register_simple("imx-pcm-audio",
> 
This is still IMX vs. PowerPC thing rather than "old binding" vs. "new
binding" one.

> This prohibits me from using the new binding on any future PowerPC parts,
> because it clearly says "iMX" on everything.

I think we can change it later when the future PowerPC parts come to
use the new binding.  In any case, I do not see this is an issue that
should block the whole series.

-- 
Regards,
Shawn
