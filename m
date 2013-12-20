From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 10:52:23 +0100
Subject: [PATCH v3 1/9] ASoC: fsl-ssi: Fix probe error handling
In-Reply-To: <20131219130334.GZ31886@sirena.org.uk>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-2-git-send-email-mpa@pengutronix.de>
 <20131219130334.GZ31886@sirena.org.uk>
Message-ID: <20131220095223.GG23493@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 19, 2013 at 01:03:34PM +0000, Mark Brown wrote:
> On Wed, Dec 18, 2013 at 12:57:37PM +0100, Markus Pargmann wrote:
> > This patch fixes the error handling in the fsl-ssi probe function.
> 
> This doesn't apply against current code, please check and resend.

Okay, I will rebase on your topic/fsl again.

> 
> >  error_irqmap:
> > -	irq_dispose_mapping(ssi_private->irq);
> > +	if (ssi_private->use_dma && !of_device_is_compatible(pdev->dev.of_node,
> > +				"fsl,imx21-ssi"))
> > +		irq_dispose_mapping(ssi_private->irq);
> 
> This test is icky, a flag set when we create the mapping would be neter.

Fixed.

Thanks,

Markus


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
