From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 10 Mar 2013 15:47:10 -0300
Subject: [PATCH 01/10] imx-ssi: Fix AC97 rates
In-Reply-To: <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CAOMZO5A8F81PzCjKHrkZ_AtGMr341d6OmYHMQvdzgunmGFDVsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Sun, Mar 10, 2013 at 3:33 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> This device supports multiple rates as described in later AC97
> standards. This patch allows playback of different sample frequencies
> without conversion.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  sound/soc/fsl/imx-ssi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Currently we have the following ssi drivers for imx:

sound/soc/fsl/imx-ssi.c: for i.mx SoCs running on non-dt platform
sound/soc/fsl/fsl_ssi.c: for PowerPC and i.mx SoCs running on dt platforms

I see that in this series you convert sound/soc/fsl/imx-ssi.c into dt.

Shouldn't we use sound/soc/fsl/fsl_ssi.c instead and maybe even get
rid of sound/soc/fsl/imx-ssi.c when all imx become converted to dt?
