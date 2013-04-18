From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 18 Apr 2013 13:57:24 +0530
Subject: [V3 patch 03/19] ARM: OMAP3: remove cpuidle_wrap_enter
In-Reply-To: <1365770165-27096-4-git-send-email-daniel.lezcano@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-4-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <516FAE6C.3050002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
> In a previous commit the en_core_tk_irqen flag has been added but we missed
> the cpuidle_wrap_enter which was doing the job to measure the time for the
> 'omap3_enter_idle' function.
> 
> Actually, I don't see any reason to use this wrapper in the code. In the better
> case, the time computation is not correctly done because of the different
> operations done in omap3_enter_idle_bm which were not taken into account
> before the en_core_tk_irqen flag was set.
> 
> As the time is reflected for the state overridden by the omap3_enter_idle_bm,
> using the wrapper is pointless now, so removing it.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
