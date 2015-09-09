From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 09 Sep 2015 03:16:48 +0200
Subject: [PATCH v5 0/4] cpufreq-dt: add suspend frequency support
In-Reply-To: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
References: <1441730464-7947-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <2547413.Uj7KDUeGpY@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 08, 2015 06:41:00 PM Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds suspend frequency support (using opp-v2
> bindings and suspend-opp functionality) to cpufreq-dt driver and
> then adds suspend opp for Exynos4412 based boards.
> 
> This patch series fixes suspend/resume support on Exynos4412
> based Trats2 board and reboot hang on Exynos4412 based Odroid
> U3 board.
> 
> Changes since v4:
> - removed superfluous CONFIG_PM ifdefs
> - added Acked-by tag from Krzysztof to patch #4
> - added Acked-by tag from Viresh to patches #1-3
> 
> Changes since v3:
> - fixed dev_pm_opp_get_suspend_opp() locking
> - shortened variable name in dev_pm_opp_get_suspend_opp()
> - adjusted cpufreq_generic_suspend() to work with cpufreq-dt
> - removed no longer needed cpufreq_dt_suspend()
> - added Acked-by tag from Viresh to patch #4
> 
> Changes since v2:
> - rewrote to use suspend-opp functionality
> 
> Changes since v1:
> - removed superfluous ";"
> 
> Depends on:
> - next-20150902 branch of linux-next kernel tree

I've queued up [1-3/4] for the next PM pull request.

The [4/4] has to go in separately through the platform tree.

Thanks,
Rafael
