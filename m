From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 15 Mar 2015 01:48:09 +0000
Subject: [PATCH v6 0/4] irqchip: move away from gic_arch_extn.irq_set_wake
In-Reply-To: <1426088737-15817-1-git-send-email-marc.zyngier@arm.com>
References: <1426088737-15817-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150315014809.GD4463@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Wed, Mar 11, 2015 at 03:45:33PM +0000, Marc Zyngier wrote:
> This series is extracted from [4], which is trying to remove all
> traces of gic_arch_extn from the tree. As some maintainers are more
> responsive than others (understatement of the year...), I've decided
> to split it per sub-arch, and get it moving, at least partially.
> 
> This small set of patches slightly modifies some of the least
> offending platforms, by providing a much limited hook into the GIC
> driver.
> 
> Based on 4.0-rc1.
> 
> * From v5: [5]
> - No change
> 
> * From v4: [4]
> - Extracted from the full series
> - Rebased on 4.0-rc1
> 
> * From v3 [3]:
> - Rebased on top of the patch working around hardcoded IRQ on OMAP4/5 [4]
> - Fixed more iMX6 DTs (Stephan)
> - Fixed Exynos4/5 DTs
> 
> * From v2 [2]:
> - Addressed numerous comments from Thierry
> - Merged bug fixes from Nishanth
> - Merged bug fix from Stefan
> 
> * From v1 [1]:
> - Rebased on 3.19-rc3
> - Fixed a number of additional platforms
> - Added crossbar conversion to stacked domains
> - Merged bug fixes from Nishanth
> 
> [5]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325190.html
> [4]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/317531.html
> [3]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315385.html
> [2]: http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/314041.html
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/307338.html
> 
> Marc Zyngier (4):
>   irqchip: gic: add an entry point to set up irqchip flags
>   ARM: shmobile: remove use of gic_arch_extn.irq_set_wake
>   ARM: ux500: switch from gic_arch_extn to gic_set_irqchip_flags
>   ARM: zynq: switch from gic_arch_extn to gic_set_irqchip_flags
> 
>  arch/arm/mach-shmobile/intc-sh73a0.c   | 7 +------
>  arch/arm/mach-shmobile/setup-r8a7779.c | 7 +------
>  arch/arm/mach-ux500/cpu.c              | 2 +-
>  arch/arm/mach-zynq/common.c            | 2 +-
>  drivers/irqchip/irq-gic.c              | 5 +++++
>  include/linux/irqchip/arm-gic.h        | 1 +
>  6 files changed, 10 insertions(+), 14 deletions(-)

Applied to irqchip/stacked-irq_set_wake.  I know, not the best name... :)

thx,

Jason.
