From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 11:35:12 +0100
Subject: [PATCH 3/3] ARM: only select ARM_PATCH_PHYS_VIRT if MMU is enabled
In-Reply-To: <1404295043-6661-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1404295043-6661-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140702103512.GG32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 11:57:23AM +0200, Uwe Kleine-K?nig wrote:
> This fixes the following warning:
> 
> 	warning: (ARCH_MULTIPLATFORM && ARCH_INTEGRATOR && ARCH_SHMOBILE_LEGACY) selects ARM_PATCH_PHYS_VIRT which has unmet direct dependencies (!XIP_KERNEL && MMU && (!ARCH_REALVIEW || !SPARSEMEM))
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> I'm not sure why ARCH_MULTIPLATFORM appears here. It depends on MMU,
> isn't selectable at the same time as ARCH_REALVIEW and XIP_KERNEL
> depends on !ARCH_MULTIPLATFORM.

The message is extremely confusing.  It would read better if those
&& were || - because ARM_PATCH_PHYS_VIRT is selected by
ARCH_MULTIPLATFORM _or_ ARCH_INTEGRATOR _or_ ARCH_SHMOBILE_LEGACY:

config ARCH_MULTIPLATFORM
        select ARM_PATCH_PHYS_VIRT

config ARCH_INTEGRATOR
        select ARM_PATCH_PHYS_VIRT

config ARCH_SHMOBILE_LEGACY
        select ARM_PATCH_PHYS_VIRT

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
