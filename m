From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 14 Mar 2013 17:35:13 +0100
Subject: [PATCH] mmc: mxcmmc: DT support
In-Reply-To: <20130314165048.08416241@crub>
References: <1361816885-3033-1-git-send-email-mpa@pengutronix.de>
 <20130314165048.08416241@crub>
Message-ID: <20130314163513.GF32452@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 04:50:48PM +0100, Anatolij Gustschin wrote:
> On Mon, 25 Feb 2013 19:28:05 +0100
> Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > Adding devicetree support for imx21-mmc and imx31-mmc. Based on generic
> > gpio helper functions by Guennadi and generic DMA devicetree bindings.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  .../devicetree/bindings/mmc/fsl-imx-mmc.txt        | 24 +++++++
> >  drivers/mmc/host/mxcmmc.c                          | 80 +++++++++++++++++-----
> >  2 files changed, 86 insertions(+), 18 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
> > new file mode 100644
> > index 0000000..a5ab662
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
> > @@ -0,0 +1,24 @@
> > +* Freescale Secure Digital Host Controller for i.MX1/2 series
> 
> shouldn't it be "... for i.MX2/3 series"?
> 
> ...
> > +	if (!host->pdata) {
> > +		host->dma = of_dma_request_slave_channel(pdev->dev.of_node,
> > +				"rx-tx");
> 
> please use dma_request_slave_channel(&pdev->dev, "rx-tx")
> here. of_dma_request_slave_channel() is not exported for
> modules, building the driver as a module will fail.

Thank you, I changed both in version 2.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
