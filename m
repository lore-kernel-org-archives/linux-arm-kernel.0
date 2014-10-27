From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Oct 2014 13:37:27 -0700
Subject: [PATCHv2 6/9] arm: perf: kill get_hw_events()
In-Reply-To: <1414411599-1938-7-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
 <1414411599-1938-7-git-send-email-mark.rutland@arm.com>
Message-ID: <544EAD07.5010406@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 05:06 AM, Mark Rutland wrote:
> Now that the arm pmu code is limited to CPU PMUs the get_hw_events()
> function is superfluous, as we'll always have a set of per-cpu
> pmu_hw_events structures.
>
> This patch removes the get_hw_events() function, replacing it with
> a percpu hw_events pointer. Uses of get_hw_events are updated to use
> this_cpu_ptr.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
