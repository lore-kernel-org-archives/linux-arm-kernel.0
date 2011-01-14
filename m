From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 14 Jan 2011 11:06:40 +0100
Subject: [PATCH] Introduce VPR200 board.
In-Reply-To: <20110114083408.GD24920@pengutronix.de>
References: <1294962532-15790-1-git-send-email-marc@cpdesign.com.au>
	<1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
	<20110114083408.GD24920@pengutronix.de>
Message-ID: <20110114100640.GA4589@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> > +static void vpr200_init_keys(void)
> > +{
> > +	gpio_request(GPIO_BUTTON1, "BUTTON1");
> > +	gpio_direction_input(GPIO_BUTTON1);
> > +	gpio_free(GPIO_BUTTON1);
> > +
> > +	gpio_request(GPIO_BUTTON2, "BUTTON2");
> > +	gpio_direction_input(GPIO_BUTTON2);
> > +	gpio_free(GPIO_BUTTON2);
> > +
> > +	gpio_request(GPIO_BUTTON3, "BUTTON3");
> > +	gpio_direction_input(GPIO_BUTTON3);
> > +	gpio_free(GPIO_BUTTON3);
> > +
> > +	gpio_request(GPIO_BUTTON4, "BUTTON4");
> > +	gpio_direction_input(GPIO_BUTTON4);
> > +	gpio_free(GPIO_BUTTON4);
> > +
> > +	gpio_request(GPIO_BUTTON5, "BUTTON5");
> > +	gpio_direction_input(GPIO_BUTTON5);
> > +	gpio_free(GPIO_BUTTON5);
> > +
> > +	gpio_request(GPIO_BUTTON6, "BUTTON6");
> > +	gpio_direction_input(GPIO_BUTTON6);
> > +	gpio_free(GPIO_BUTTON6);
> > +
> > +	gpio_request(GPIO_BUTTON7, "BUTTON7");
> > +	gpio_direction_input(GPIO_BUTTON7);
> > +	gpio_free(GPIO_BUTTON7);
> > +
> > +	gpio_request(GPIO_BUTTON8, "BUTTON8");
> > +	gpio_direction_input(GPIO_BUTTON8);
> > +	gpio_free(GPIO_BUTTON8);
> Hmm, doesn't the gpio-keys driver does that already?

I'd think so, too.

> And to do it really correct, you need to check for errors returned by
> gpio_request and gpio_direction_input.
> 
> Provided you really need it, I'd do it as follows:
> 
> 	int ret;
> 
> 	#define setup_for_gpiokey(nr)					\
> 		ret = gpio_request(GPIO_BUTTON ## nr, "BUTTON" #nr);	\
> 		if (ret)						\
> 			return ret;					\
> 		ret = gpio_direction_input(GPIO_BUTTON ## nr);		\
> 		if (ret)						\
> 			return ret;					\
> 		gpio_free(GPIO_BUTTON ## nr);
> 
> 	setup_for_gpiokey(1);
> 	setup_for_gpiokey(2);
> 	setup_for_gpiokey(3);
> 	setup_for_gpiokey(4);
> 	...

I'd think using gpio_request_array() is the better option ;)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110114/a5c66e98/attachment.sig>
