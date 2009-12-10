From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Dec 2009 17:57:22 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <4B1ECEEE.3000209@bluewatersys.com>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
Message-ID: <20091210165721.GI19454@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> This is still really screwy. Why are you creating your own version of
> struct gpio_chip in addition to the one in include/asm-generic/gpio.h
> (which you also appear to include in some places). It makes the code
> extremely confusing. Other architectures use wrapper structures. Can you
> have something like this instead:
> 
> 	struct dream_gpio_chip {
> 		struct gpio_chip chip;
> 
> 		/* Dream specific bits */
> 	};

Well, unfortunately dream's gpio_chip definition is completely
different to the one from include/asm-generic. I'll do the rename.

> The name of this function also needs to be changed to something less
> generic since it is being exported globally.

Well, arm only ever supports one subarch, so...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
