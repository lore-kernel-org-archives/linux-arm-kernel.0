From: haavard.skinnemoen@atmel.com (Haavard Skinnemoen)
Date: Wed, 28 Oct 2009 09:31:31 +0800
Subject: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
In-Reply-To: <d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	<20090930155557.7dae503b@hskinnemoen-d830>
	<a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	<cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
	<20091028083548.38f1d80c@hskinnemoen-d830>
	<d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
Message-ID: <20091028093131.0f8d8340@hskinnemoen-d830>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thiago A. Corr?a <thiago.correa@gmail.com> wrote:
> >> Causes at91_set_gpio_input() to be called for pin -1. ?Which shouldn't be valid.
> >> AT91 platforms use 0 to indicate an un-connected GPIO pin, so the
> >> assignment of "wp_pin" should probably just be removed.  
> >
> > The mci driver expects non-existent pins to have a negative value, as
> > do all other drivers which use gpio_is_valid().
> >  
> 
> Then I think it would be best to use GPIO_PIN_NONE. Makes it clear
> what is expected and avoids confusion on what should be the proper
> value.

Unfortunately, GPIO_PIN_NONE only exists on AVR32.

> I hope I'm not saying non-sense, but even if I am, I guess you can see
> that I'm advocating against the magic numbers :)

IIRC, the correct way to specify a non-existent pin is to use -ENODEV.

Haavard
