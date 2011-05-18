From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 May 2011 22:02:47 +0200
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <BANLkTi=TDiAziQU0fYBiK_Npk0x50av7tA@mail.gmail.com>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110503172712.GE6538@lunn.ch>
	<BANLkTi=ncV3M1q5SXNdUaXmtfkZ8Wn9dmw@mail.gmail.com>
	<20110515133312.GM4071@lunn.ch>
	<BANLkTi=O_mZEqMhOS_Fz0vAYCQ-XpyG4UA@mail.gmail.com>
	<BANLkTi=TDiAziQU0fYBiK_Npk0x50av7tA@mail.gmail.com>
Message-ID: <BANLkTikUbxHQH-sAP+uOy7bnpZcyN_GHxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/17 Kyungmin Park <kmpark@infradead.org>:

> In this case we only need to set the function at interrupt by like
> s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
> So pinmux function provides this feature also.

This function:
s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));

Isn't part of the gpiolib I can see, I am discussing with Grant
how to handle custom GPIO configuration. Looking in
archa/arm/plat-samsung/include/plat/gpio-core.h
it looks like you have your own reimplementation of the
entire gpiolib in order to get these special configuration
functions... (So hopefully if I can add custom GPIO
configs to gpiolib, all of this can move to drivers/gpio/*)

So I don't know exactly what this means, if it means that you want to
mux pin 0xf to become GPIO, then yes, in the pinmux framework
you would:

pinmux_request_gpio(pinno, gpiono);

(As you see pins and GPIOs are now in different address spaces
and that is why two number have to be given, but if you manage
it the number space it can basically be the same number if
the platform so permits.)

Yours,
Linus Walleij
