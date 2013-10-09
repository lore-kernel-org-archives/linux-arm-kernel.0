From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 10:59:38 +0800
Subject: [PATCH 1/4] clk: tegra124: add wait_for_reset and disable_clock
 for tegra_cpu_car_ops
In-Reply-To: <5254381E.9060100@wwwdotorg.org>
References: <1381220587-29697-1-git-send-email-josephl@nvidia.com>
 <1381220587-29697-2-git-send-email-josephl@nvidia.com>
 <5254381E.9060100@wwwdotorg.org>
Message-ID: <1381287578.10638.12.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-09 at 00:51 +0800, Stephen Warren wrote:
> On 10/08/2013 02:23 AM, Joseph Lo wrote:
> > Hook the functions for CPU hotplug support. After the CPU is hot
> > unplugged, the flow controller will handle to clock gate the CPU clock.
> > But still need to implement an empty function to avoid warning message.
> > 
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> > This patch depends on the patch series "[PATCH 0/5] Tegra124 clock support"
> > that sent by Peter on 10/4/2013.
> 
> Uggh. This series mixes patches for drivers/clk and arch/arm/mach-tegra.
> I don't want to introduce dependencies between those two subsystems.
> Instead, if this patch is applied to the clock tree, and the reset of
> the patches to the Tegra tree, will that cause any build issues, or any
> run-time for any SoC other than Tegra124 (which is a new feature so it's
> fine if it doesn't work until everything is merged together)?

This patch can go through the clock tree and won't cause any build
issues or run-time failure even on Tegra124 (except CPU hot plug stress
testing). Only some warning message would show up.

But I am going to send some other patches for platform suspend support
for Tegra124, it might meet the issue you mentioned here. We only can
test it in our local tree or wait for the next linux-next (20131028?)
for testing after everything merged. So it might be OK, I guess.
