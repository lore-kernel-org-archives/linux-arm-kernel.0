From: bn@niasdigital.com (Ben Nizette)
Date: Tue, 03 Nov 2009 09:14:57 +1100
Subject: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
In-Reply-To: <4AEF12B7.3040704@atmel.com>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	<20090930155557.7dae503b@hskinnemoen-d830>
	<a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	<cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
	<20091028083548.38f1d80c@hskinnemoen-d830>
	<d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
	<cd73a99e0910281253x1bb72b74p47cb5110efb0871f@mail.gmail.com>
	<1256763057.4362.36.camel@ben-desktop>  <4AEF12B7.3040704@atmel.com>
Message-ID: <1257200097.4358.54.camel@ben-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[apologies for the MTA fart causing that weird, rouge blank email :-) ]

On Mon, 2009-11-02 at 18:11 +0100, Nicolas Ferre wrote:
> Ben Nizette :
> > 
> > static inline int gpio_is_valid(int number)
> > {
> > 	/* only some non-negative numbers are valid */
> > 	return ((unsigned)number) < ARCH_NR_GPIOS;
> > }
> 
> I understand that the better way to solve this issue is to:
> - keep the AT91 way of specifying not connected pins (= 0)
> - code the gpio_is_valid() function for at91 that tests this way of
> handling not connected gpio
> 

I'm not sure I'd break cross-arch compat here, but whatever.  I guess it
depends how deeply the =0 stuff is ingrained in the at91 codebase

> I see that in arch/arm/mach-at91/include/mach/gpio.h
> we include the asm-generic/gpio.h file... must I implement the full set
> of gpiolib ?

I'd suggest creating an ARCH_HAVE_GPIO_VALID (darn, long name) or
something; define it before #include <asm-generic/gpio.h> and #ifdef
protect the offending declaration in that header.

	--Ben.

> 
> Best regards,
