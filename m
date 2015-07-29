From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 29 Jul 2015 08:46:54 +0200
Subject: [PATCH 1/9] gpiolib: Fix possible use of wrong name
In-Reply-To: <20150728090331.GI28535@localhost>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <1437125570-28623-2-git-send-email-mpa@pengutronix.de>
 <20150728090331.GI28535@localhost>
Message-ID: <20150729064654.GB30895@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 11:03:31AM +0200, Johan Hovold wrote:
> On Fri, Jul 17, 2015 at 11:32:42AM +0200, Markus Pargmann wrote:
> > The name is set optionally from DT. Therefore we need to reset the name
> > variable for every loop iteration. Otherwise we could use a wrong or
> > uninitialized name.
> 
> This doesn't make sense. of_get_gpio_hog falls back to using the node
> name so name will always be updated (unless there's an error).
> 
> Could be better documented, though.

Thanks, just got the two lines wrong. Yes the name is always set
correctly.
Will fix it.

Best regards,

Markus

> 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/gpio/gpiolib-of.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > index 9a0ec48a4737..60aebe4d7c26 100644
> > --- a/drivers/gpio/gpiolib-of.c
> > +++ b/drivers/gpio/gpiolib-of.c
> > @@ -209,11 +209,11 @@ static void of_gpiochip_scan_hogs(struct gpio_chip *chip)
> >  {
> >  	struct gpio_desc *desc = NULL;
> >  	struct device_node *np;
> > -	const char *name;
> >  	enum gpio_lookup_flags lflags;
> >  	enum gpiod_flags dflags;
> >  
> >  	for_each_child_of_node(chip->of_node, np) {
> > +		const char *name = NULL;
> >  		if (!of_property_read_bool(np, "gpio-hog"))
> >  			continue;
> 
> Johan
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/d49f77bb/attachment.sig>
