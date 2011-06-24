From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Jun 2011 14:14:50 +0100
Subject: [PATCH] clocksource/arm_smp_twd: handle frequency changes
In-Reply-To: <1308559687-30768-1-git-send-email-linus.walleij@stericsson.com>
References: <1308559687-30768-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E048DCA.8070700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/11 09:48, Linus Walleij wrote:
> From: Colin Cross <ccross@android.com>
> 
> First add a clock called "smp_twd" that is used to determine the
> twd frequency, which can also be used at init time to avoid
> calibrating the twd frequency since we already know it.
> 
> Then the localtimer's clock changes with the cpu clock, since the
> block has only one clock input. After a cpufreq transition, update
> the clockevent's frequency and reprogram the next clock event
> so we stay tight on the scheduled timeline.
> 
> Clock changes are based on Rob Herring's work.
> 
> This patch depends on the whole localtimer rewrite and move
> shebang from Marc Zyngier, and that in turn depends on other
> stuff.
> 
> Signed-off-by: Colin Cross <ccross@android.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [ifdef:ed CPUfreq stuff - rebased to Marc Z patches]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Marc, if you're pursuing this series, consider merging this on top,
> it is needed for the new ARM A9 small-form factor reference platform
> whatever it is called.

Linus,

I've applied the attached patch on top of this one, just removing a now
superfluous variable. No functional changes.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
