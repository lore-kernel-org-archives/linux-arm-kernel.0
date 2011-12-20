From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 19 Dec 2011 16:41:31 -0800
Subject: [PATCH 01/20] ARM: clean up idle handlers
In-Reply-To: <1324288069-21940-2-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-2-git-send-email-nico@fluxnic.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92C29@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote at Monday, December 19, 2011 2:48 AM:
> Let's factor out the need_resched() check instead of having it duplicated
> in every pm_idle implementations to avoid inconsistencies (omap2_pm_idle
> was missing it already).
> 
> The forceful re-enablement of IRQs after pm_idle has returned can go.
> The warning certainly doesn't trigger for existing users.  Similar for
> the redundant local_irq_disable() call in the OMAP implementations.
> 
> To get rid of the pm_idle calling convention oddity, let's introduce
> arm_pm_idle() allowing for the local_irq_enable() to be factored out
> from SOC specific implementations. The default pm_idle function becomes
> a wrapper for arm_pm_idle and it takes care of enabling IRQs closer to
> where they are initially disabled.
> 
> And finally move the comment explaining the reason for that turning off
> of IRQs to a more proper location.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

The parts which affect Tegra,

Acked-by: Stephen Warren <swarren@nvidia.com>

Also,

Tested-by: Stephen Warren <swarren@nvidia.com>

(which IIUC for Tegra means booting with these patches applied, and
running nothing much so that the CPU is idle, since we don't yet support
any power management)

-- 
nvpublic
