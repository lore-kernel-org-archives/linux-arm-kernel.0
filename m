From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 4 May 2018 22:19:20 +0800
Subject: [PATCH 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB
 and the MAILBOX
In-Reply-To: <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
 <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
Message-ID: <20180504141920.GA17313@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 04, 2018 at 11:14:35AM +0800, Leo Yan wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The current defconfig is inconsistent as it selects the mailbox and
> the clock for the hi6220 and the hi3660 without having their Kconfigs
> making sure the dependencies are correct. It ends up when selecting
> different versions for the kernel (for example when git bisecting)
> those options disappear and they don't get back, leading to unexpected
> behaviors. In our case, the cpufreq driver does no longer work because
> the clock fails to initialize due to the clock stub and the mailbox
> missing.
> 
> In order to have the dependencies correctly set when defaulting, let's
> do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
> automatically") where we select automatically the driver when the
> parent driver is selected. With sensible defaults in place, we can leave
> other choices for EXPERT.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Jassi,

Could you review and ack for this patch?

Hi Wei,

Stephen has acked this patch and if we can get ack from Jassi, could
you pick up this patch?

I missed my Signed-off-by tag, this might break the chain.
So when you pick up this patch, please add my Signed-off-by tag:

Signed-off-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo Yan
