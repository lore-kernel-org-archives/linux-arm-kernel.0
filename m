From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 4 Apr 2013 12:46:02 +0530
Subject: [PATCH 6/9] ARM: davinci: cpuidle: fix wrong enter function
In-Reply-To: <1364991322-20585-6-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <1364991322-20585-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <515D28B2.90408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2013 5:45 PM, Daniel Lezcano wrote:
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
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
