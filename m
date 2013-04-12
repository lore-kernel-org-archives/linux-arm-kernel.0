From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 22:42:36 +0200
Subject: [PATCH v5 03/14] clocksource: samsung-pwm: Add infrastructure to
 share PWM hardware
In-Reply-To: <1365794250-14436-4-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
 <1365794250-14436-4-git-send-email-t.figa@samsung.com>
Message-ID: <201304122242.36801.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 April 2013, Tomasz Figa wrote:
> +
> +Samsung SoCs contain PWM timer blocks which can be used for system clock source
> +and clock event timers, as well as to drive SoC outputs with PWM signal. Each
> +PWM timer block provides 5 PWM channels (not all of them can drive physical
> +outputs - see SoC and board manual).
> +
...
> +Optional properties:
> +- samsung,pwm-outputs: list of PWM channels used as PWM outputs on particular
> +    platform - an array of up to 5 elements being indices of PWM channels
> +    (from 0 to 4), the order does not matter.
> +

There is probably a good reason, but can you explain why this is actually required
to be a property? Wouldn't it be enough to just not refer to the PWM outputs from
other devices when they are not used?

	Arnd
