From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Nov 2015 09:47:37 -0500 (EST)
Subject: [PATCH] drivers/reset: appropriate __init annotation for const
 data
In-Reply-To: <1448276217.4008.22.camel@pengutronix.de>
References: <alpine.LFD.2.20.1511212053530.22569@knanqh.ubzr>
 <1448276217.4008.22.camel@pengutronix.de>
Message-ID: <alpine.LFD.2.20.1511230943510.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Nov 2015, Philipp Zabel wrote:

> Hi Nicolas,
> 
> Am Samstag, den 21.11.2015, 20:56 -0500 schrieb Nicolas Pitre:
> > Init data marked const should be annotated with __initconst for
> > correctness and not __initdata.  This also fixes LTO builds that
> > otherwise fail with section mismatch errors.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
> > index 3d95c87160..9353b2dd15 100644
> > --- a/drivers/reset/reset-sunxi.c
> > +++ b/drivers/reset/reset-sunxi.c
> > @@ -122,7 +122,7 @@ err_alloc:
> >   * our system, before we can even think of using a regular device
> >   * driver for it.
> >   */
> > -static const struct of_device_id sunxi_early_reset_dt_ids[] __initdata = {
> > +static const struct of_device_id sunxi_early_reset_dt_ids[] __initconst = {
> >  	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
> >  	{ /* sentinel */ },
> >  };
> 
> Thank you for the patch, this change is already contained in the latest
> pull request sent to the arm-soc maintainers.

OK.  I initially posted it in July but it didn't show up in v4.2 nor in 
v4.3. I concluded it fell into a crack.


Nicolas
