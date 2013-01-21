From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Jan 2013 10:21:08 -0700
Subject: [PATCH] ARM: architected timers: allow dt based discovery using
 clocksource_of_init
In-Reply-To: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
References: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <50FD7904.1070201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2013 06:22 PM, Thomas Abraham wrote:
> Add an entry in __clksrc_of_table so that ARMv7 architected timer is
> discoverable using call to clocksource_of_init.

> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c

> +#ifdef CONFIG_CLKSRC_OF
> +CLOCKSOURCE_OF_DECLARE(armv7_timer, "arm,armv7-timer", arch_timer_of_register)
> +#endif

I wonder if we shouldn't enhance include/linux/clocksource.h to define
CLOCKSOURCE_OF_DECLARE even when !CONFIG_CLKSRC_OF; that way, drivers
wouldn't need that ifdef.
