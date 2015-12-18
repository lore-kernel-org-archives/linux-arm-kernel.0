From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 18 Dec 2015 15:14:10 +0200
Subject: [PATCH v4] clocksource: arm_global_timer: fix suspend resume
In-Reply-To: <1448907912-15512-1-git-send-email-grygorii.strashko@ti.com>
References: <1448907912-15512-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <567406A2.1050906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
On 11/30/2015 08:25 PM, Grygorii Strashko wrote:
> Now the System stall is observed on TI AM437x based board
> (am437x-gp-evm) during resuming from System suspend when ARM Global
> timer is selected as clocksource device (CPUIdle not enabled) - SysRq are working,
> but nothing else.
> 
> The reason of stall is that ARM Global timer loses its contexts during
> System suspend:
>     GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
>     GT_COUNTERx = 0
> 
> Hence, update ARM Global timer driver to reflect above behaviour
> - re-enable ARM Global timer on resume (GT_CONTROL.TIMER_ENABLE = 1)
>    if not enabled.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Are there any comments? Do I need to perform any additional actions to have it merged?



-- 
regards,
-grygorii
