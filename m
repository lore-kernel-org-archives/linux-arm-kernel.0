From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 7 Feb 2013 12:35:36 +0100
Subject: [PATCH v4 0/8] watchdog/at91sam9_wdt: Convert to use the new
 framework
In-Reply-To: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
References: <1359702386-21284-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <51139188.8030601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2013 08:06 AM, Wenyou Yang :
> Hi, All
> 
> The purpose of the patch series is to convert at91sam9_wdt to use the watchdog framework,
>  
> Because the Watchdog Mode Register(WDT_MR) which WDDIS bit to disable or disable the watchdog
> can be written only once after reset. so if you want to use the watchdog in the kernel, 
> you must be sure the watchdog doesn't be disabled in the at91bootstrap.
> 
> It is tested on at91sam9m10g45ek both DT and non-DT support, at91sam9g25ek with DT support
> by building Documentation/watchdog/src/watchdog-simple.c.
> 
> It is based on v3.8-rc6 + Arnd Bergmann's at91_wdt_dt_ids cannot be __init
> 			+ Fabio Porcedda's add timeout-sec property binding

On my side, I give my acknowledgement to the whole patch series:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I hope that once Fabio Porcedda's series is merged, this series can be
applied on top of it seamlessly and quickly.

Wim,
Tell us if you need that we resend this series or rebase it on top of
another git tree.

Thanks for your work and for your reviews.

Best regards,

> ChangeLog 
> v4:
>   - remove the patch: Use module_platform_driver().
>   - add tested on at91sam9m10g45ek both DT and non-DT support.
>   - rebase on v3.8-rc6 
> 
> v3:
>   - The helper function 'watchdog_is_open' is moved to include/linux/watchdog.h
>   - Remove '__init' annotation from the function 'at91wdt_probe'
>   - Rebase on v3.8-rc2
> 
> v2:
>   - Remove the patches to add devive tree support which Fabio Porcedda has applied.
>   - Replace __raw_readl, __raw_writel with readl_relaxed, writel_relaxed.
>   - Rebase on v3.7-rc8.
> 
> Best Regards
> Wenyou Yang
> 
> Wenyou Yang (8):
>   watchdog: add the function watchdog_is_open
>   watchdog/at91sam9_wdt: Remove at91wdt_private and add at91wdt_drvdata
>     struct
>   watchdog/at91sam9_wdt: Convert to use the watchdog framework
>   watchdog/at91sam9_wdt: Adjust the options of watchdog_info
>   watchdog/at91sam9_wdt: Add nowayout helpers to Watchdog Timer Driver
>     Kernel API
>   watchdog/at91sam9_wdt: Remove the __initdata of at91wdt_wdd
>   ARM: dts: add the watchdog nodes for at91sam9x5 and at91sam9n12 SoC
>   ARM: dts: add the watchdog nodes for at91sam9g25ek and
>     at91sam9m10g45ek boards
> 
>  arch/arm/boot/dts/at91sam9m10g45ek.dts |    4 +
>  arch/arm/boot/dts/at91sam9n12.dtsi     |    6 +
>  arch/arm/boot/dts/at91sam9x5.dtsi      |    6 +
>  arch/arm/boot/dts/at91sam9x5ek.dtsi    |    4 +
>  drivers/watchdog/at91sam9_wdt.c        |  272 +++++++++++++-------------------
>  include/linux/watchdog.h               |    8 +
>  6 files changed, 140 insertions(+), 160 deletions(-)
> 


-- 
Nicolas Ferre
