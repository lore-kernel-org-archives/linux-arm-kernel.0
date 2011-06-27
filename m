From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 Jun 2011 11:51:20 +0200
Subject: [PATCH v2 0/6] Some fixes and cleanup on imx-dma device
	registration
In-Reply-To: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
References: <1308753691-14442-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110627095120.GA6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 10:41:25PM +0800, Shawn Guo wrote:
> The patch set makes some small fixes on imx-dma device registration
> code, and then cleans up the code by breaking the concentrated
> imx-dma device registration into soc specific setup function.
> This is basically what gpio-mxc device registration is doing.
> In this way, we can avoid the churn of "#ifdef" and the cpu_is_mx
> checking on such a long list of soc family, which makes no sense,
> considering more soc supports need to be added and we need to
> support single image for multiple socs in the long run.
> 
> Changes since v1:
>  * Drop the patch #5 in v1 and add another one to pass firmware
>    name as a string via platform data
>  * Rebase it on Sascha's tree
> 
> Shawn Guo (6):
>       ARM: mxc: imx-sdma device gets 16K iosize than 4K
>       ARM: mxc: sdma on imx25 is a V2 block
>       ARM: mxc: change imx-dma default to_version to 1
>       ARM: mxc: imx-dma on imx25 has no other TO version but TO1
>       ARM: mxc: clean up imx-dma device registration
>       dmaengine: imx-sdma: pass sdma firmware name via platform data

Applied to -next.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
