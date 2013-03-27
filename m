From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Mar 2013 13:47:00 -0600
Subject: [PATCH 4/5] arm: fix up ARM_ARCH_TIMER selects
In-Reply-To: <1364404312-4427-5-git-send-email-mark.rutland@arm.com>
References: <1364404312-4427-1-git-send-email-mark.rutland@arm.com>
 <1364404312-4427-5-git-send-email-mark.rutland@arm.com>
Message-ID: <51534CB4.20009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 11:11 AM, Mark Rutland wrote:
> In 8a4da6e: "arm: arch_timer: move core to drivers/clocksource", the
> selection of ARM_ARCH_TIMER was indirected via HAVE_ARM_ARCH_TIMER,
> though mach-exynos's selection of ARM_ARCH_TIMER was missed, and since
> then mach-virt and mach-tegra have begun selecting ARM_ARCH_TIMER. This
> can lead to architected timer support erroneously appearing to not be
> selected in menuconfig.
> 
> This patch fixes up the Kconfigs for those platforms to select
> HAVE_ARM_ARCH_TIMER.

Acked-by: Stephen Warren <swarren@nvidia.com>

I assume you'll take this patch through some tree of yours.
