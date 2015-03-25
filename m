From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Mar 2015 14:34:30 -0700
Subject: [PATCH V3 2/8] ARM: cpuidle: Add a cpuidle ops structure to be
 used for DT
In-Reply-To: <1426851841-2072-3-git-send-email-daniel.lezcano@linaro.org>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <1426851841-2072-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20150325213430.GA30227@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20, Daniel Lezcano wrote:
> The current state of the different cpuidle drivers is the different PM
> operations are passed via the platform_data using the platform driver
> paradigm.
> 
> This approach allowed to split the low level PM code from the arch specific
> and the generic cpuidle code.
> 
> Unfortunately there are complaints about this approach as, in the context of the
> single kernel image, we have multiple drivers loaded in memory for nothing and
> the platform driver is not adequate for cpuidle.
> 
> This patch provides a common interface via cpuidle ops for all new cpuidle
> driver and a definition for the device tree.
> 
> It will allow with the next patches to a have a common definition with ARM64
> and share the same cpuidle driver.
> 
> The code is optimized to use the __init section intensively in order to reduce
> the memory footprint after the driver is initialized and unify the function
> names with ARM64.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Kevin Hilman <khilman@linaro.org>
> Acked-by: Rob Herring <robherring2@gmail.com>

Thanks for moving to OF tables. We can merge smp ops and cpuidle
ops later on.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
