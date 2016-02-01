From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 1 Feb 2016 11:58:16 -0800
Subject: [PATCH v2] clocksource/arm_arch_timer: Enable and verify MMIO
 access
In-Reply-To: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
References: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
Message-ID: <20160201195816.GL4848@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01, Robin Murphy wrote:
> So far, we have been blindly assuming that having access to a
> memory-mapped timer frame implies that the individual elements of that
> frame frame are already enabled. Whilst it's the firmware's job to give
> us non-secure access to frames in the first place, we should not rely
> on implementations always being generous enough to also configure CNTACR
> for those non-secure frames (e.g. [1]).
> 
> Explicitly enable feature-level access per-frame, and verify that the
> access we want is really implemented before trying to make use of it.
> 
> [1]:https://github.com/ARM-software/tf-issues/issues/170
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
