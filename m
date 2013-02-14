From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Feb 2013 08:59:04 -0800
Subject: Getting your opinion about the best place to put one specific
 device driver...
In-Reply-To: <CACRpkdbGLoXY=g_pkF42FZgH+8yRUnKafvMmab_gwqDhYpE69A@mail.gmail.com>
References: <511A0F11.1050608@stericsson.com>
 <201302121741.31494.arnd@arndb.de>
 <511B59E2.5060402@stericsson.com>
 <201302131104.01793.arnd@arndb.de>
 <CACRpkdbGLoXY=g_pkF42FZgH+8yRUnKafvMmab_gwqDhYpE69A@mail.gmail.com>
Message-ID: <20130214165903.GA7144@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130214 00:56]:
> 
> The hardware observer already use the pinctrl interfaces from
> pinctrl-nomadik.c to set up the pins per se: i.e. to set up so
> that these pins are available to put signals on. But then we
> can plug this stuff as a front-end, and yeah.
> drivers/pinctrl/ux500-hwobs.c might be a good idea!

Just please try to keep the data added to kernel to minimum..

The user space app can decipher what each register means
based on the register address + SoC model. Kernel just needs
to be able to route the signals.

Otherwise we'll end up with data for each SoC in the kernel,
which we're trying to avoid :)

Regards,

Tony
