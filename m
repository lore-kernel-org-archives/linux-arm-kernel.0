From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 3 Nov 2014 14:38:40 +0100
Subject: [PATCH v2 3/4] regulator: fixed: Use gpio_is_valid
In-Reply-To: <20141013144733.GK27755@sirena.org.uk>
References: <1412776028-15655-1-git-send-email-mpa@pengutronix.de>
 <1412776028-15655-4-git-send-email-mpa@pengutronix.de>
 <20141013144733.GK27755@sirena.org.uk>
Message-ID: <20141103133840.GF24292@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 04:47:33PM +0200, Mark Brown wrote:
> On Wed, Oct 08, 2014 at 03:47:07PM +0200, Markus Pargmann wrote:
> > Use gpio_is_valid instead of an explicit comparison with 0.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/regulator/fixed.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
> > index 441a3e90e266..696f53cc1927 100644
> > --- a/drivers/regulator/fixed.c
> > +++ b/drivers/regulator/fixed.c
> > @@ -157,7 +157,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
> >  
> >  	drvdata->desc.fixed_uV = config->microvolts;
> >  
> > -	if (config->gpio >= 0) {
> > +	if (gpio_is_valid(config->gpio)) {
> 
> Have you audited all users to ensure that they don't rely on zero being
> ignored?  Right now we're sharing the core behaviour here so the same
> issues apply to this platform data as apply to the core.

For all other drivers this should be fine (just rechecked again). But
the fixed regulator driver patch has this problem.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141103/4fa6afdc/attachment.sig>
