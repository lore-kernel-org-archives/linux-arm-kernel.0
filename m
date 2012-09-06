From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Sep 2012 09:15:14 +0200
Subject: [PATCH 7/8] pwm i.MX: fix clock lookup
In-Reply-To: <1698432111.3713458.1346881731396.JavaMail.root@advansee.com>
References: <1346852127-25226-8-git-send-email-s.hauer@pengutronix.de>
 <1698432111.3713458.1346881731396.JavaMail.root@advansee.com>
Message-ID: <20120906071514.GM26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 11:48:51PM +0200, Beno?t Th?baudeau wrote:
> >  
> > -	c = clk_get_rate(imx->clk);
> > +	c = clk_get_rate(imx->clk_per);
> >  	c = c * period_ns;
> >  	do_div(c, 1000000000);
> >  	period_cycles = c;
> > @@ -160,8 +161,15 @@ static int imx_pwm_config(struct pwm_chip *chip,
> >  		struct pwm_device *pwm, int duty_ns, int period_ns)
> >  {
> >  	struct imx_chip *imx = to_imx_chip(chip);
> > +	int ret;
> >  
> > -	return imx->config(chip, pwm, duty_ns, period_ns);
> > +	clk_prepare_enable(imx->clk_ipg);
> 
> Why don't you test the return value like in imx_pwm_enable()?

Will do next time.

Sascha

> 
> I have reviewed the whole series. Apart from the comments I made, it looks good
> to me.

Thanks. I can take this as a reviewed-by, right?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
