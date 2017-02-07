From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 7 Feb 2017 15:57:36 +0100
Subject: [PATCH v2 3/3] gpiolib: Add GPIO initialization
In-Reply-To: <20170207143031.4700300a@ipc1.ka-ro>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-4-git-send-email-mpa@pengutronix.de>
 <20170207110950.zy5pzo2hq6hrvmr5@pengutronix.de>
 <20170207143031.4700300a@ipc1.ka-ro>
Message-ID: <20170207145736.vtwkzovmxjcgwncq@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lothar,

On Tue, Feb 07, 2017 at 02:30:31PM +0100, Lothar Wa?mann wrote:
> On Tue, 7 Feb 2017 12:09:50 +0100 Uwe Kleine-K?nig wrote:
> >  a)
> >  	/*
> > 	 * initially configured as low output. Consumer can do
> > 	 * gpio_set_value(..., 1); but not gpio_direction_input(...);
> > 	 */
> >  	nodename {
> > 		gpio-hog;
> > 		gpios = <...>;
> > 		output-low-init;
> > 	};
> > 
> >  b)
> >  	/*
> > 	 * initially configured as low output. Consumer can do
> > 	 * gpio_set_value(..., 1); and gpio_direction_input(...);
> > 	 */
> >  	nodename {
> > 		gpio-hog;
> > 		gpios = <...>;
> > 		output-init-low;
> > 	};
> > 
> >  c)
> >  	/*
> > 	 * initially configured as input. Consumer can do
> > 	 * gpio_direction_output(..., ...) and then set the value
> > 	 * freely.
> > 	 */
> > 	 nodename {
> > 	 	gpio-hog;
> > 		gpios = <...>;
> > 		input-init;
> > 	};
> > 
> > I don't like that "output-low-init" and "output-init-low" are so
> > similar, so if someone suggests a better naming scheme, that would be
> > great.
> > 
> The position of the 'output' or 'input' within the word could
> imply whether the direction can be changed lateron or not. E.g.:
> output-init-low => an output whose state is initially low, but can be
>                    reconfigured to high lateron.

That's your a) which I called output-low-init

> init-low-output => a gpio that is initially configured as output low,  
>                    but can subsequently be reconfigured as input or to
>                    a different state

That's your b) which I called output-init-low.
 
> init-input      => your case c)
... which I called input-init.

> input           => a GPIO input that cannot be reconfigured

This is just a permutation of words, and so doesn't fix the problem that
a) and b) use similar words. For you it's "init" before the stuff
that can be changed. For me it's "init" is after the stuff that can be
changed. 
I slightly prefer my naming here because we already have "output-low"
and "output-high" and my names also use direction-before-value.

But I interpret your reply as interest and general confirmation that the
idea is fine.

> This would also allow an 'output-low' as a GPIO that is permanently
> grounded...

That works already today.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
