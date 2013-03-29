From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Mar 2013 17:06:05 +0530
Subject: [PATCH 7/9] ARM: davinci: cpuidle: fix wrong enter function
In-Reply-To: <1364553095-25110-7-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-7-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51557CA5.3060208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
> The davinci_enter_idle is called from the cpuidle with the
> cpuidle_wrap_enter function. This one does the time compution
> for entering and exiting the idle function and then we call
> again cpuidle_wrap_enter for cpu_do_idle. This is wrong, we
> are calling recursively cpuidle_wrap_enter for nothing and
> furthermore reenabling the local irq.
> 
> Remove this and replace it by the cpu_do_idle function.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
Looks right to me.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
