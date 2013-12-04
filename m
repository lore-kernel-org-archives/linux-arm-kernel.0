From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 4 Dec 2013 01:40:50 +0000
Subject: [PATCH v3 10/10] usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK
In-Reply-To: <529E5215.5000107@pengutronix.de>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
 <1383616525-10769-11-git-send-email-peter.chen@freescale.com>
 <529E5215.5000107@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A6498041427E5@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> 
> On 11/05/2013 02:55 AM, Peter Chen wrote:
> > Enable CI_HDRC_IMX_EHCI_QUIRK for controllers who use mxs-phy.
> >
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c |   17 ++++++++++++++---
> >  1 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c
> b/drivers/usb/chipidea/ci_hdrc_imx.c
> > index fd26c38..78ccde1 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -25,6 +25,7 @@
> >
> >  #define CI_HDRC_IMX_IMX28_WRITE_FIX		BIT(0)
> >  #define CI_HDRC_IMX_SUPPORT_RUNTIME_PM		BIT(1)
> > +#define CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK		BIT(2)
> >
> >  struct ci_hdrc_imx_platform_flag {
> >  	unsigned int flags;
> > @@ -33,17 +34,24 @@ struct ci_hdrc_imx_platform_flag {
> >  static const struct ci_hdrc_imx_platform_flag imx27_usb_data = {
> >  };
> >
> > +static const struct ci_hdrc_imx_platform_flag imx23_usb_data = {
> > +	.flags = CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK,
> > +};
> > +
> >  static const struct ci_hdrc_imx_platform_flag imx28_usb_data = {
> > -	.flags = CI_HDRC_IMX_IMX28_WRITE_FIX,
> > +	.flags = CI_HDRC_IMX_IMX28_WRITE_FIX |
> > +		CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK,
> >  };
> >
> >  static const struct ci_hdrc_imx_platform_flag imx6q_usb_data = {
> > -	.flags = CI_HDRC_IMX_SUPPORT_RUNTIME_PM,
> > +	.flags = CI_HDRC_IMX_SUPPORT_RUNTIME_PM |
> > +		CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK,
> >  };
> >
> >  static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
> >  	{ .compatible = "fsl,imx6q-usb", .data = &imx6q_usb_data},
> >  	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
> > +	{ .compatible = "fsl,imx23-usb", .data = &imx23_usb_data},
> >  	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
> >  	{ /* sentinel */ }
> >  };
> > @@ -153,11 +161,14 @@ static int ci_hdrc_imx_probe(struct
> platform_device *pdev)
> >  	if (imx_platform_flag->flags & CI_HDRC_IMX_IMX28_WRITE_FIX)
> >  		pdata.flags |= CI_HDRC_IMX28_WRITE_FIX;
> >
> > -	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM)
> > +	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM) {
>                                                                     ^^^^
> 
> Please squash into the correct patch.
> 
 
There are some re-work for this serial, I will do it.
But I don't get your mean why it needs to squash into another patch?

Peter
