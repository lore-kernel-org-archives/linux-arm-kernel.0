From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 30 May 2018 10:08:06 +0530
Subject: [PATCH 07/15] arm: dts: exynos: Add missing cooling device
 properties for CPUs
In-Reply-To: <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <cfd8de4b2ad1cfd7b0f1a0706c0b6b918e1ebffc.1527244201.git.viresh.kumar@linaro.org>
 <CAJKOXPcyV=fdRu7oLXHMimSFR9ktJ23uBriswTStkEkAMbTaNw@mail.gmail.com>
Message-ID: <20180530043806.ksen4xyh3x3x4fqn@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-05-18, 15:18, Krzysztof Kozlowski wrote:
> Thanks for the patch.
> 
> In case of Exynos, the booting CPU always has these information in DT
> and the booting CPU cannot be changed (chosen by firmware/hardware
> configuration).

But can the booting CPU be offlined ?

If yes, then this is how things are broken right now.

Build cpufreq driver as module, boot kernel, hotplug out CPU0, insert
cpufreq driver and that will try to find these properties in CPU1.

> Therefore there is no real risk of falling although
> for correctness of DT your change makes sense.
> 
> It is too late for this cycle for me so I'll pick it up after merge window.
> Alternatively, arm-soc guys can pick it up directly with my tag:
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

No worries, you can pick it up later on.

-- 
viresh
