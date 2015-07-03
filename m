From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 03 Jul 2015 16:58:44 +0200
Subject: [PATCH] clocksource: dw_apb_timer: add dynamic irq flag to the
 timer
In-Reply-To: <1435933847-2069-1-git-send-email-jszhang@marvell.com>
References: <1435933847-2069-1-git-send-email-jszhang@marvell.com>
Message-ID: <5596A324.4040800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2015 04:30 PM, Jisheng Zhang wrote:
> Commit d2348fb6fdc6 ("tick: Dynamically set broadcast irq affinity")
> adds one excelent feature CLOCK_EVT_FEAT_DYNIRQ to let the core set the
> interrupt affinity of the broadcast interrupt to the cpu which has the
> earliest expiry time. This patch adds CLOCK_EVT_FEAT_DYNIRQ flag to
> avoid unnecessary wakeups and IPIs when the dw_apb_timer is used as
> broadcast timer.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---

I am glad this flag helps. Were you able to do some measurements ?

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
