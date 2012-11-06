From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 06 Nov 2012 14:40:32 -0700
Subject: [PATCH] gpiolib: iron out include ladder mistakes
In-Reply-To: <1352218863-2037-1-git-send-email-linus.walleij@stericsson.com>
References: <1352218863-2037-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <509983D0.1060107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2012 09:21 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The <*/gpio.h> includes are updated again: now we need to account
> for the problem introduced by commit:
> 595679a8038584df7b9398bf34f61db3c038bfea
> "gpiolib: fix up function prototypes etc"
> 
> Actually we need static inlines in include/asm-generic/gpio.h
> as well since we may have GPIOLIB but not PINCTRL.
> 
> And we need to keep the static inlines in <linux/gpio.h>
> but here for the !CONFIG_GENERIC_GPIO case, and then we
> may as well throw in a few warnings like the other
> prototypes there, if someone would have the bad taste
> of compiling without GENERIC_GPIO even.

Hmm. Is there way to avoid the duplication of the dummy implementations?
Having a prototype and a truly dummy implementation in one place, but a
WARNing/failing dummy implementation elsewhere, seems like it'll cause
issues.

Does this patch mean the previous series causes "git bisect" failures?
