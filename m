From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 8 Feb 2016 15:30:56 +0100
Subject: [PATCH v2] clocksource/arm_arch_timer: Enable and verify MMIO
 access
In-Reply-To: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
References: <71bf617f4083b116b2aeab24f13fc5fed99a816f.1454327031.git.robin.murphy@arm.com>
Message-ID: <56B8A6A0.4080704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2016 01:00 PM, Robin Murphy wrote:
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

Applied to my tree for 4.6.

Thanks

   - Daniel
