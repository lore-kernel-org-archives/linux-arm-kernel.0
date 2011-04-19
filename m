From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Tue, 19 Apr 2011 17:52:10 +0400
Subject: [PATCHv2 2.6.40 3/3] ARM:simpad: add GPIO based device
	definitions.
In-Reply-To: <1303131636-19442-4-git-send-email-jochen@scram.de>
References: <1303131636-19442-1-git-send-email-jochen@scram.de>
	<1303131636-19442-4-git-send-email-jochen@scram.de>
Message-ID: <20110419135210.GA2182@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:00 Mon 18 Apr     , Jochen Friedrich wrote:
> Register LED, keyboard, polled keyboard and I2C platform
> devices based on GPIOs.
> 
> V2: Remove the legacy ARM LED code for simpad devices.

Yeah, that looks like a good move! IMO, legacy ARM leds code should go
away, as we have now proper generic LED subsystem, and the sooner we
convert all legacy users to leds-class drivers, the better.

> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/arm/mach-sa1100/Makefile      |    1 -
>  arch/arm/mach-sa1100/leds-simpad.c |   97 ------------------------------------
>  arch/arm/mach-sa1100/simpad.c      |   95 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 94 insertions(+), 99 deletions(-)
>  delete mode 100644 arch/arm/mach-sa1100/leds-simpad.c

But, while removing leds-simpad.c, it seems you forgot to update both
Makefile and corresponding entries in leds.[ch], so I suspect it will
break build with CONFIG_LEDS=y.

And, while you're at it, it's probably a good idea to move all these LED
changes into separate patch, and not to mix them with gpio-keys/i2c/etc
devices registration.

-- 
Best regards,
Dmitry "MAD" Artamonow
