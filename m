From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 24 Jan 2013 08:27:14 +0100
Subject: [PATCH] i2c: at91: add of_device_id entry for at91rm9200
In-Reply-To: <20121218060232.GL23971@game.jcrosoft.org>
References: <1354743732-11581-1-git-send-email-manabian@gmail.com>
 <20121218060232.GL23971@game.jcrosoft.org>
Message-ID: <20130124072714.GH8364@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 07:02:32AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:42 Wed 05 Dec     , Joachim Eastwood wrote:
> > Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> > ---
> > Hi,
> > 
> > AT91RM9200 is gaining DT support now so let's add an id to the i2c driver.
> > 
> > Tested on custom RM9200 board. Since the driver doesn't support pinctrl
> > muxing yet I had to add pinctrl hogs for the i2c pins in my dts for it
> > to work.
> 
> IIRC the i2c IP have quite a lots of issue on rm9200 and until sam9g45
> 
> it not recommended to use it instead use i2c-gpio

Ludovic, you know the driver best. Does it make sense to add this?

> 
> Best Regards,
> J.
> > 
> > regards
> > Joachim Eastwood
> > 
> >  drivers/i2c/busses/i2c-at91.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> > index b4575ee..c504aa8 100644
> > --- a/drivers/i2c/busses/i2c-at91.c
> > +++ b/drivers/i2c/busses/i2c-at91.c
> > @@ -584,6 +584,9 @@ static const struct platform_device_id at91_twi_devtypes[] = {
> >  #if defined(CONFIG_OF)
> >  static const struct of_device_id atmel_twi_dt_ids[] = {
> >  	{
> > +		.compatible = "atmel,at91rm9200-i2c",
> > +		.data = &at91rm9200_config,
> > +	} , {
> >  		.compatible = "atmel,at91sam9260-i2c",
> >  		.data = &at91sam9260_config,
> >  	} , {
> > -- 
> > 1.8.0
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
