From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Mar 2012 18:39:10 +0100
Subject: [PATCH v2 10/17] ASoC: imx: merge sound/soc/imx into sound/soc/fsl
In-Reply-To: <1330957865-19085-11-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <1330957865-19085-11-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120305173910.GZ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 10:30:58PM +0800, Shawn Guo wrote:
> Freescale PowerPC and ARM/IMX families share the same SSI IP block.
> The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
> code sharing and consolidation can happen.
> 
> This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
> in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
> IMX platform.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/Kconfig                        |    1 -
>  sound/soc/Makefile                       |    1 -
>  sound/soc/fsl/Kconfig                    |   92 ++++++++++++++++++++++++++++++
>  sound/soc/fsl/Makefile                   |   22 +++++++
>  sound/soc/{imx => fsl}/eukrea-tlv320.c   |    2 +-
>  sound/soc/{imx => fsl}/imx-audmux.c      |    0
>  sound/soc/{imx => fsl}/imx-audmux.h      |    0
>  sound/soc/{imx => fsl}/imx-pcm-dma-mx2.c |    0

Maybe this is the right time to rename this file to something like
imx-pcm-dma.c since it has nothing to do with mx2 anymore.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
