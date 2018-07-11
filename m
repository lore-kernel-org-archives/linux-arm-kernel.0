From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 11 Jul 2018 16:10:04 +0200
Subject: [PATCH -next] pinctrl: at91-pio4: remove redundant return value
 check of platform_get_resource()
In-Reply-To: <20180711130349.GP16084@piout.net>
References: <1531312447-134423-1-git-send-email-weiyongjun1@huawei.com>
 <20180711130349.GP16084@piout.net>
Message-ID: <20180711141004.cuzmomutxofw7blb@M43218.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 03:03:49PM +0200, Alexandre Belloni wrote:
> On 11/07/2018 12:34:07+0000, Wei Yongjun wrote:
> > Remove unneeded error handling on the result of a call
> > to platform_get_resource() when the value is passed to
> > devm_ioremap_resource().
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> I'm not sure it is worth the effort but

I have the same feeling. If it's the trend:
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> > ---
> >  drivers/pinctrl/pinctrl-at91-pio4.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> > index 8f06197..ef7ab20 100644
> > --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> > +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> > @@ -971,10 +971,6 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
> >  	atmel_pioctrl->npins = atmel_pioctrl->nbanks * ATMEL_PIO_NPINS_PER_BANK;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	if (!res) {
> > -		dev_err(dev, "unable to get atmel pinctrl resource\n");
> > -		return -EINVAL;
> > -	}
> >  	atmel_pioctrl->reg_base = devm_ioremap_resource(dev, res);
> >  	if (IS_ERR(atmel_pioctrl->reg_base))
> >  		return -EINVAL;
> > 
> > 
> > 
> 
> -- 
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
