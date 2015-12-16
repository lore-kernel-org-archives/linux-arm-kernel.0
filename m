From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 16 Dec 2015 21:58:09 +0100
Subject: [PATCH v3 1/2] ARM: cpuidle: remove cpu parameter from the
 cpuidle_ops suspend hook
In-Reply-To: <1445011379-8787-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1445011379-8787-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1445011379-8787-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5671D061.6060008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2015 06:02 PM, Lorenzo Pieralisi wrote:
> The suspend() hook in the cpuidle_ops struct is always called on
> the cpu entering idle, which means that the cpu parameter passed
> to the suspend hook always corresponds to the local cpu, making
> it somewhat redundant.
>
> This patch removes the logical cpu parameter from the ARM
> cpuidle_ops.suspend hook and updates all the existing kernel
> implementations to reflect this change.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Lina Iyer <lina.iyer@linaro.org>
> Tested-by: Lina Iyer <lina.iyer@linaro.org>
> Tested-by: Jisheng Zhang <jszhang@marvell.com> [psci]
> Cc: Lina Iyer <lina.iyer@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
