From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 11 Mar 2013 20:51:08 +0100
Subject: [PATCH 01/10] imx-ssi: Fix AC97 rates
In-Reply-To: <CAOMZO5A8F81PzCjKHrkZ_AtGMr341d6OmYHMQvdzgunmGFDVsw@mail.gmail.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-2-git-send-email-mpa@pengutronix.de>
 <CAOMZO5A8F81PzCjKHrkZ_AtGMr341d6OmYHMQvdzgunmGFDVsw@mail.gmail.com>
Message-ID: <20130311195108.GC18350@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Sun, Mar 10, 2013 at 03:47:10PM -0300, Fabio Estevam wrote:
> Hi Markus,
> 
> On Sun, Mar 10, 2013 at 3:33 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > This device supports multiple rates as described in later AC97
> > standards. This patch allows playback of different sample frequencies
> > without conversion.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  sound/soc/fsl/imx-ssi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Currently we have the following ssi drivers for imx:
> 
> sound/soc/fsl/imx-ssi.c: for i.mx SoCs running on non-dt platform
> sound/soc/fsl/fsl_ssi.c: for PowerPC and i.mx SoCs running on dt platforms
> 
> I see that in this series you convert sound/soc/fsl/imx-ssi.c into dt.
> 
> Shouldn't we use sound/soc/fsl/fsl_ssi.c instead and maybe even get
> rid of sound/soc/fsl/imx-ssi.c when all imx become converted to dt?
> 

At the moment fsl-ssi and imx-ssi don't seem to have very much in
common. However I could try to merge the imx-ssi driver code into
fsl_ssi and make it handle imx27-ssi differently.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
