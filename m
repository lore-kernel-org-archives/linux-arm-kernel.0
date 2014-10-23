From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Oct 2014 17:23:55 +0200
Subject: [PATCH 4/4] watchdog: st_wdt: Add new driver for ST's LPC Watchdog
In-Reply-To: <1414077524-6469-5-git-send-email-lee.jones@linaro.org>
References: <1414077524-6469-1-git-send-email-lee.jones@linaro.org>
 <1414077524-6469-5-git-send-email-lee.jones@linaro.org>
Message-ID: <8501493.uUGsNVQOhe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 October 2014 16:18:44 Lee Jones wrote:
> +config ST_WATCHDOG
> +       tristate "STMicroelectronics LPC Watchdog"
> +       depends on ARCH_STI && OF
> +       depends on !RTC_DRV_ST_LPC
> +       select WATCHDOG_CORE
> +       help
> +        Say Y here to include Watchdog timer support for the watchdog
> +        existing in the LPC of STMicroelectronics SOCs.
> +        !!! BE CARREFUL !!!
> +        This driver shares hardware resources with RTC Alarm part of the
> +        LPC. Both LPC Watchdog driver and LPC RTC driver cannot be
> +        used together.
> +
> +        To compile this driver as a module, choose M here: the
> +        module will be called st-wdt.
> +
> 

How is this ensured by the code? Do both drivers try to bind to the
same device node? Would it make more sense to have a single driver
that registers both to the rtc and the watchdog subsystems?

	Arnd
