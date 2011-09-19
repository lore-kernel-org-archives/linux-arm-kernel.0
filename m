From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Sep 2011 11:10:01 +0200
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <201108091515.47961.arnd@arndb.de>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<CAKnu2MpjOT8y5DfeAtrgBAKh0asqNouyhuin=z+ScAwx0Fa5rA@mail.gmail.com>
	<CAGsJ_4yb9vvKYzyXwQSwaBw1VnZWbv4jGBC4qe7uD032DL0y9A@mail.gmail.com>
	<201108091515.47961.arnd@arndb.de>
Message-ID: <CACRpkda6Bz_0odpLXokDdkPMyQKD6x5GnD52xnKZmDw1_sXW8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 August 2011, Barry Song wrote:

> Or do we want to delete the whole arch/arm/mach-xxx/include/mach directory?
>
> If not, it is probably that SoC can still hold some chip-specific APIs
> in arch/arm/mach-xxx/include/mach/yyy.h.

I was actually proposing patches that moved GPIO headers from
<mach/foo-gpio> to <linux/gpio/foo.h> but they were NAK:ed or
frowned upon, so I guess we're keeping the <mach/*> include
union namespace for machine/SoC-specific headers.

Now we just try to make files in this namespace have unqiue
names.

Yours,
Linus Walleij
