From: bn@niasdigital.com (Ben Nizette)
Date: Thu, 29 Oct 2009 07:50:57 +1100
Subject: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
	at91sam9g45 chip and board
In-Reply-To: <cd73a99e0910281253x1bb72b74p47cb5110efb0871f@mail.gmail.com>
References: <acfa557032a93e2d3186981b16f7048a5a31028a.1256314995.git.nicolas.ferre@atmel.com>
	<20090930155557.7dae503b@hskinnemoen-d830>
	<a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com>
	<cd73a99e0910271243x744c956bl598fef9fd4144840@mail.gmail.com>
	<20091028083548.38f1d80c@hskinnemoen-d830>
	<d6cda7730910271753o54acfa04t1225de460083325f@mail.gmail.com>
	<cd73a99e0910281253x1bb72b74p47cb5110efb0871f@mail.gmail.com>
Message-ID: <1256763057.4362.36.camel@ben-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-10-28 at 21:53 +0200, Andrew Victor wrote:
> hi,
> 
> > Then I think it would be best to use GPIO_PIN_NONE. Makes it clear
> > what is expected and avoids confusion on what should be the proper
> > value.
> > I hope I'm not saying non-sense, but even if I am, I guess you can see
> > that I'm advocating against the magic numbers :)
> 
> What magic numbers ?

I think Thiago was referring to the "-1" in the original patch as the
magic number.

Leaving the field blank to be initialised to 0 is certainly the
cleanest, I agree, but it doesn't actually /work/.  On many archs 0 is a
valid gpio number; the gpio_is_valid check used throughout the kernel
(including atmel-mci.c) looks like

static inline int gpio_is_valid(int number)
{
	/* only some non-negative numbers are valid */
	return ((unsigned)number) < ARCH_NR_GPIOS;
}

	--Ben.
