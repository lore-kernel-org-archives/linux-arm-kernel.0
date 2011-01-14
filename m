From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Jan 2011 11:18:20 +0100
Subject: [PATCH] Introduce VPR200 board.
In-Reply-To: <20110114100640.GA4589@pengutronix.de>
References: <1294962532-15790-1-git-send-email-marc@cpdesign.com.au>
	<1294962532-15790-2-git-send-email-marc@cpdesign.com.au>
	<20110114083408.GD24920@pengutronix.de>
	<20110114100640.GA4589@pengutronix.de>
Message-ID: <20110114101820.GH24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Jan 14, 2011 at 11:06:40AM +0100, Wolfram Sang wrote:
> > And to do it really correct, you need to check for errors returned by
> > gpio_request and gpio_direction_input.
> > 
> > Provided you really need it, I'd do it as follows:
> > 
> > 	int ret;
> > 
> > 	#define setup_for_gpiokey(nr)					\
> > 		ret = gpio_request(GPIO_BUTTON ## nr, "BUTTON" #nr);	\
> > 		if (ret)						\
> > 			return ret;					\
> > 		ret = gpio_direction_input(GPIO_BUTTON ## nr);		\
> > 		if (ret)						\
> > 			return ret;					\
> > 		gpio_free(GPIO_BUTTON ## nr);
> > 
> > 	setup_for_gpiokey(1);
> > 	setup_for_gpiokey(2);
> > 	setup_for_gpiokey(3);
> > 	setup_for_gpiokey(4);
> > 	...
> 
> I'd think using gpio_request_array() is the better option ;)
didn't know that one, nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
