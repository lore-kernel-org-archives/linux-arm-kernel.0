From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 10:19:49 -0600
Subject: [PATCH] ARM: tegra: cpuidle: replace LP3 with
 ARM_CPUIDLE_WFI_STATE
In-Reply-To: <1349691856-30590-1-git-send-email-josephl@nvidia.com>
References: <1349691856-30590-1-git-send-email-josephl@nvidia.com>
Message-ID: <5072FD25.2020600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 04:24 AM, Joseph Lo wrote:
> The Tegra CPU idle LP3 state is doing ARM WFI only. So it's same with
> the common ARM_CPUIDLE_WFI_STATE. Using it to replace LP3 now.

Hmm. This changes the exit_latency/target_residency fields of the
cpuidle state definition from 10 to 1, and also replaces
tegra_idle_enter_lp3() with just a dsb/wfi as far as I can tell. What
are the implications of removing the irq/fiq_disable/enable and
ktim-related code? It might be worth explaining why this change is valid
in the commit description.
