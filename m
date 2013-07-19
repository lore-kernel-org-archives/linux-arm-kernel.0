From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Jul 2013 10:52:33 -0600
Subject: [PATCH V4 0/4] ARM: tegra114: cpuidle: add power down state
In-Reply-To: <1374225926-26832-1-git-send-email-josephl@nvidia.com>
References: <1374225926-26832-1-git-send-email-josephl@nvidia.com>
Message-ID: <51E96ED1.9020300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2013 03:25 AM, Joseph Lo wrote:
> This series introduce CPU core power down state for CPU idle. When CPU go
> into this state, it saves it's context and needs a proper configuration
> in flow controller to power gate the CPU when CPU runs into WFI
> instruction. And the CPU also needs to set the IRQ as CPU power down idle
> wake up event in flow controller.
> 
> To prevent race conditions and ensure proper interrupt routing on
> Cortex-A15 CPUs when they are power-gated, add a CPU PM notifier
> call-back to reprogram the GIC CPU interface on PM entry. The
> GIC CPU interface will be reset back to its normal state by
> the common GIC CPU PM exit callback when the CPU wakes up.
> 
> And the Tegra114 support CPU0 hotplug function in HW physically, but it
> needs other software to make it work normally after we add CPU idle power
> down mode support. But we don't support that yet, removing them for now.

OK, this version works fine, so I have applied it to Tegra's
for-3.12/soc. I hope we can resolve the issues with
CPUIDLE_FLAG_TIMER_STOP and CPU0 hot plug soon though.
