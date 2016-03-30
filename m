From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 30 Mar 2016 10:02:02 +0200
Subject: [PATCH v2] ARM: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
In-Reply-To: <1459324077-7116-1-git-send-email-jszhang@marvell.com>
References: <1459324077-7116-1-git-send-email-jszhang@marvell.com>
Message-ID: <56FB87FA.50405@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2016 09:47 AM, Jisheng Zhang wrote:
> Currently, we check cpuidle_ops.suspend every time when entering a
> low-power idle state. But this check could be avoided in this hot path
> by moving it into arm_cpuidle_read_ops() to reduce arm_cpuidle_suspend
> overhead a bit.

This patch makes sense but the ARM64 part is missing.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
