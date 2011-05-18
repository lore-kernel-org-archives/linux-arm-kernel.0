From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 May 2011 22:21:55 +0100
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <BANLkTikUbxHQH-sAP+uOy7bnpZcyN_GHxQ@mail.gmail.com>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110503172712.GE6538@lunn.ch>
	<BANLkTi=ncV3M1q5SXNdUaXmtfkZ8Wn9dmw@mail.gmail.com>
	<20110515133312.GM4071@lunn.ch>
	<BANLkTi=O_mZEqMhOS_Fz0vAYCQ-XpyG4UA@mail.gmail.com>
	<BANLkTi=TDiAziQU0fYBiK_Npk0x50av7tA@mail.gmail.com>
	<BANLkTikUbxHQH-sAP+uOy7bnpZcyN_GHxQ@mail.gmail.com>
Message-ID: <20110518212154.GA20909@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2011 at 10:02:47PM +0200, Linus Walleij wrote:
> 2011/5/17 Kyungmin Park <kmpark@infradead.org>:

> > In this case we only need to set the function at interrupt by like
> > s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
> > So pinmux function provides this feature also.

> This function:
> s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));

> Isn't part of the gpiolib I can see, I am discussing with Grant
> how to handle custom GPIO configuration. Looking in
> archa/arm/plat-samsung/include/plat/gpio-core.h

> it looks like you have your own reimplementation of the
> entire gpiolib in order to get these special configuration
> functions... (So hopefully if I can add custom GPIO
> configs to gpiolib, all of this can move to drivers/gpio/*)

This API predates the generic GPIO API - it's a reimplementation because
at that time the various platforms all had their own custom APIs.  The
Samsung specific API is pretty much only used for the pin mux and mode
configuration these days.
