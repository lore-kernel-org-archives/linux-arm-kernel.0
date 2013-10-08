From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Oct 2013 10:51:42 -0600
Subject: [PATCH 1/4] clk: tegra124: add wait_for_reset and disable_clock
 for tegra_cpu_car_ops
In-Reply-To: <1381220587-29697-2-git-send-email-josephl@nvidia.com>
References: <1381220587-29697-1-git-send-email-josephl@nvidia.com>
 <1381220587-29697-2-git-send-email-josephl@nvidia.com>
Message-ID: <5254381E.9060100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 02:23 AM, Joseph Lo wrote:
> Hook the functions for CPU hotplug support. After the CPU is hot
> unplugged, the flow controller will handle to clock gate the CPU clock.
> But still need to implement an empty function to avoid warning message.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> This patch depends on the patch series "[PATCH 0/5] Tegra124 clock support"
> that sent by Peter on 10/4/2013.

Uggh. This series mixes patches for drivers/clk and arch/arm/mach-tegra.
I don't want to introduce dependencies between those two subsystems.
Instead, if this patch is applied to the clock tree, and the reset of
the patches to the Tegra tree, will that cause any build issues, or any
run-time for any SoC other than Tegra124 (which is a new feature so it's
fine if it doesn't work until everything is merged together)?
