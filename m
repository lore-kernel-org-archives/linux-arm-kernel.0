From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Oct 2014 13:37:38 -0700
Subject: [PATCHv2 3/9] arm: perf: make PMU probing data-driven
In-Reply-To: <1414411599-1938-4-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
 <1414411599-1938-4-git-send-email-mark.rutland@arm.com>
Message-ID: <544EAD12.2040704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 05:06 AM, Mark Rutland wrote:
> The current PMU probing logic consists of a single switch statement,
> which means that the core arm_pmu core in perf_event_cpu.c needs to know
> about every CPU PMU variant supported by a driver using the arm_pmu
> framework. This makes it rather difficult to decouple the drivers from
> the (otherwise generic) probing code.
>
> The patch refactors that switch statement to a table-driven lookup,
> separating the logic and knowledge (in the form of the table). Later
> patches will split the table across the relevant PMU drivers, which can
> pass their tables to the generic probing function.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
