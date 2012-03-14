From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 14 Mar 2012 10:01:15 +0100
Subject: [PATCH v4] ASoC: add imx-sgtl5000 machine driver working with
 fsl_ssi
In-Reply-To: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120314090115.GN3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 07:58:47PM +0800, Shawn Guo wrote:
> Changes since v3:
>  * Change imx compatible to "fsl,imx21-ssi"
>  * Leave locking issue as a FIXME for Timur to sort out separately
> 
> ---
> Shawn Guo (10):
>       ASoC: fsl: separate SSI and DMA Kconfig options
>       ASoC: imx: merge sound/soc/imx into sound/soc/fsl
>       ASoC: fsl: rename imx-pcm Kconfig options and filename
>       ASoC: fsl: create fsl_utils to accommodate the common functions
>       ASoC: fsl: remove helper fsl_asoc_get_codec_dev_name
>       ASoC: fsl: check property 'compatible' for the machine name
>       ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
>       ASoC: fsl: remove the fatal error checking on codec-handle
>       ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
>       ASoC: fsl: add imx-sgtl5000 machine driver

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

What are the next steps here? Now we have fsl_ssi.c and imx-ssi.c, one
for dt bindings and the other one for platform bindings and also AC97
support. They should probably get merged some day which might be a bit
difficult since currently I don't see the platform users moving over
to devicetree and the seem to be no AC97 users in powerpc.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
