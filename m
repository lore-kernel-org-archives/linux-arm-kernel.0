From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 19 Apr 2017 20:12:43 +0200
Subject: [PATCH] arm64: arch_timer: mark errata handlers as __maybe_unused
In-Reply-To: <20170419173737.3846098-1-arnd@arndb.de>
References: <20170419173737.3846098-1-arnd@arndb.de>
Message-ID: <20170419181243.GA2523@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 07:37:09PM +0200, Arnd Bergmann wrote:
> In some rare randconfig builds, we end up with two functions being entirely
> unused:
> 
> drivers/clocksource/arm_arch_timer.c:342:12: error: 'erratum_set_next_event_tval_phys' defined but not used [-Werror=unused-function]
>  static int erratum_set_next_event_tval_phys(unsigned long evt,
> drivers/clocksource/arm_arch_timer.c:335:12: error: 'erratum_set_next_event_tval_virt' defined but not used [-Werror=unused-function]
>  static int erratum_set_next_event_tval_virt(unsigned long evt,
> 
> We could add an #ifdef around them, but we would already have to check for
> several symbols there and there is a chance this would get more complicated
> over time, so marking them as __maybe_unused is the simplest way to avoid the
> harmless warnings.
> 
> Fixes: 01d3e3ff2608 ("arm64: arch_timer: Rework the set_next_event workarounds")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
