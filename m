From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 17 Sep 2014 12:51:50 -0700
Subject: [PATCH v2] clocksource: arm_arch_timer: discard unavailable
 timers correctly
In-Reply-To: <1410982774-4724-1-git-send-email-sudeep.holla@arm.com>
References: <1410911445-19067-1-git-send-email-sudeep.holla@arm.com>
 <1410982774-4724-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140917195150.GC10233@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17, Sudeep Holla wrote:
> Currently we wait until both cp15 and mem timers are probed if we
> have both timer device nodes present in the device tree without
> checking if the device is actually available. If one of the timer
> device node present is disabled, the system locks up on the boot
> as no timer gets registered.
> 
> This patch adds the check for the availablity of the timer device
> so that we unavailable timers are discarded correctly. It also adds

s/we//

> the missing of_node_put.
> 
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Thanks.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
