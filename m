From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Feb 2014 10:40:57 +0100
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <000d01cf23b1$7c1f8de0$745ea9a0$%han@samsung.com>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <201402061708.05845.arnd@arndb.de>
 <000d01cf23b1$7c1f8de0$745ea9a0$%han@samsung.com>
Message-ID: <201402071040.58087.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 February 2014, Jingoo Han wrote:
> How about the following?
> 
>   [PATCH 1/7] ARM: pxa: don't select HAVE_PWM
>   [PATCH 2/7] ARM: lpc32xx: don't select HAVE_PWM
>   [PATCH 3/7] ARM: remove HAVE_PWM config option
>   [PATCH 4/7] MIPS: jz4740: don't select HAVE_PWM
>   [PATCH 5/7] Input: max8997_haptic: remove HAVE_PWM dependencies
>   [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies
>   [PATCH 7/7] pwm: don't use IS_ENABLED(CONFIG_HAVE_PWM)
> 
> I would like to merge it through PWM tree.
> After merging these patches, all HAVE_PWM will be removed from
> the mainline kernel. Thank you. :-)

Sounds godo to me, thanks a lot for taking care of this!
I don't see any inter-dependencies between the various patches,
so we could also take the first three through the arm-soc tree
to avoid conflicts with other changes (or possibly the third
one through rmk's ARM tree, if he prefers).

	Arnd
