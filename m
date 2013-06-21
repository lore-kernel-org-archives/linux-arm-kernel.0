From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 16:04:38 +0200
Subject: [PATCH v2 00/18] Final Samsung PWM support cleanup
In-Reply-To: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <201306211604.38443.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Tomasz Figa wrote:
> Since we now have a proper Samsung PWM clocksource driver in place,
> we can proceed with further cleanup of PWM timers support on Samsung SoCs.
> 
> This series attempts to achieve this goal by:
>  1) moving remaining Samsung platforms to the new clocksource driver
>  2) removing old clocksource driver
>  3) adding new multiplatform- and DT-aware PWM driver
>  4) moving all Samsung platforms to use the new PWM driver
>  5) removing old PWM driver
>  6) removing all PWM-related code that is not used anymore
> 
> Cleaning up the PWM driver is a bit tricky, because the design of current
> driver makes it completely unsuitable for DT and multiplatform and would
> require a heavy rework to make it usable, breaking any existing Samsung PWM
> users by the way. To avoid any breakage I decided to keep the old driver,
> add new one, move all platforms to it and then remove the old one.
> 
> See particular patches for more detailed descriptions.
> 
> On S3C6410-based Tiny6410 (Mini6410-compatible), after enabling pwm-beeper
> and Exynos4210-based Origen board (with PWM0 attached to a scope):
> 
> Tested-by: Tomasz Figa <tomasz.figa@gmail.com>
> 

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

Two small comments:

* always use 'git format-patch -M' to detect renames (patch 10)

* for new code, don't use __raw_readl and similar functions but
  use readl_relaxed or plain readl.

	Arnd
