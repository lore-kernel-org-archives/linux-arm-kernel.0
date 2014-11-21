From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Nov 2014 15:39:59 -0800
Subject: [PATCH v13 5/9] arm: omap1: Migrate debug_ll macros to use 8250.S
In-Reply-To: <1416235750-4766-6-git-send-email-daniel.thompson@linaro.org>
References: <1416235750-4766-1-git-send-email-daniel.thompson@linaro.org>
 <1416235750-4766-6-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20141121233958.GB7046@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Thompson <daniel.thompson@linaro.org> [141117 06:53]:
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

Looks OK to me, probably best that these are queued all together so:

Acked-by: Tony Lindgren <tony@atomide.com>
