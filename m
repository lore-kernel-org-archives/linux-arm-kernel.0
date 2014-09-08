From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Sep 2014 16:04:11 -0700
Subject: [PATCH v9 5/9] arm: omap1: Migrate debug_ll macros to use 8250.S
In-Reply-To: <1408461407-10429-6-git-send-email-daniel.thompson@linaro.org>
References: <1408459715-10151-1-git-send-email-daniel.thompson@linaro.org>
 <1408461407-10429-1-git-send-email-daniel.thompson@linaro.org>
 <1408461407-10429-6-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140908230411.GQ3238@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Thompson <daniel.thompson@linaro.org> [140819 08:19]:
> The omap1's debug-macro.S is similar to the generic 8250 code. Compared to
> the 8520 code the omap1 macro automatically determines what UART to use
> based on breadcrumbs left by the bootloader and automatically copes with
> the eccentric register layout on OMAP7XX.
> 
> This patch drops both these features and relies instead on the generic
> 8250 macros:
> 
> 1. Dropping support for the bootloader breadcrumbs is identical to the
>    way the migration was handled for OMAP2 (see 808b7e07464d...).
> 
> 2. Support for OMAP7XX still exists but it must be configured by hand
>    (DEBUG_OMAP7XXUART1/2/3) rather than handled at runtime.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
> Cc: linux-omap at vger.kernel.org
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

This should be safe to queue together with your other debug_ll
patches, so:

Acked-by: Tony Lindgren <tony@atomide.com>

If you want me to queue this one instead, please let me know.

Regards,

Tony
