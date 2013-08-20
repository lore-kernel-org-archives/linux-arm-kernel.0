From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Aug 2013 09:33:31 -0700
Subject: [PATCH] irqchip: gic: Allow setting affinity to offline CPUs
In-Reply-To: <1377015070-26320-1-git-send-email-t.figa@samsung.com>
References: <1377015070-26320-1-git-send-email-t.figa@samsung.com>
Message-ID: <52139A5B.5040708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/13 09:11, Tomasz Figa wrote:
> Sometimes it is necessary to fix interrupt affinity to an offline CPU,
> for example in initialization of local timers. This patch modifies
> .set_affinity() operation of irq-gic driver to fall back to any possible
> CPU if no online CPU can be found in requested CPU mask.
>
> This fixes broken Exynos4210 support since commit
> 	ee98d27df6 ARM: EXYNOS4: Divorce mct from local timer API
> caused by timer initialization code unable to set affinity for local
> timer interrupts.

Care to elaborate further? I don't see how the interrupt affinity is set
for a CPU that isn't online because the mct code runs on the CPU that
the affinity is being set to.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
