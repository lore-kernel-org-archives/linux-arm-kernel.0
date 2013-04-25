From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 16:46:27 +0200
Subject: [PATCH v3 00/13] ARM: EXYNOS: Fix Universal C210 support
In-Reply-To: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
Message-ID: <201304251646.28026.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Tomasz Figa wrote:
> This series intends to fix support for Universal C210 board in mainline.
> Main difference from other boards based on Exynos 4210 is that hardware
> revision of the SoC used on Universal C210 does not support MCT timers
> and legacy PWM timers must be used instead.
> 
> First (and the biggest) part of the series deals with cleaning up and
> fixing the samsung_pwm_timer clocksource driver, that was posted
> recently by Arnd. In addition the driver is prepared to share the
> hardware with PWM driver that will be reworked later, since it is not
> a component crucial for system operation.
> 
> Second part fixes ATAGS support of Exynos 4210 rev0 SoC, which needs
> different timer initialization, using the new samsung_pwm_timer driver.
> 
> Third and last part adds Device Tree-based support for Universal C210
> board by providing device tree sources for it.
> 
> On Universal C210 board, both with and without DT:
> 
> Tested-by: Tomasz Figa <t.figa@samsung.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Olof, Kgene, I think we should have this one in 3.10 since it fixes
a regression. It looks bigger than it really is because I asked Tomasz
to do small patches rather than a single combined patch.

	Arnd
