From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Oct 2014 14:13:07 -0700
Subject: [PATCHv2 5/9] arm: perf: limit size of accounting data
In-Reply-To: <1414411599-1938-6-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
 <1414411599-1938-6-git-send-email-mark.rutland@arm.com>
Message-ID: <544EB563.7080107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 05:06 AM, Mark Rutland wrote:
> Commit 3fc2c83087 (ARM: perf: remove event limit from pmu_hw_events) got
> rid of the upper limit on the number of events an arm_pmu could handle,
> but introduced additional complexity and places a burden on each PMU
> driver to allocate accounting data somehow. So far this has not
> generally been useful as the only users of arm_pmu are the CPU backend
> and the CCI driver.
>
> Now that the CCI driver plugs into the perf subsystem directly, we can
> remove some of the complexities that get in the way of supporting
> heterogeneous CPU PMUs.
>
> This patch restores the original limits on pmu_hw_events fields such
> that the pmu_hw_events data can be allocated as a contiguous block. This
> will simplify dynamic pmu_hw_events allocation in later patches.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>

I ran it through some Krait specific events and it looks ok.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
