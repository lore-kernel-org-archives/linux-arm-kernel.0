From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 12 Oct 2015 14:04:28 +0800
Subject: [PATCH 01/16] irqdomain: Use an accessor for the of_node field
In-Reply-To: <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
 <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <561B4D6C.7000404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 01:36 AM, Marc Zyngier wrote:
> The struct irq_domain contains a "struct device_node *" field
> (of_node) that is almost the only link between the irqdomain
> and the device tree infrastructure.
>
> In order to prepare for the removal of that field, convert all
> users to use an accessor.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/mach-omap2/omap-wakeupgen.c          |  2 +-
>   arch/c6x/platforms/megamod-pic.c              |  2 +-
>   arch/mips/cavium-octeon/octeon-irq.c          |  4 ++--
>   arch/powerpc/platforms/cell/axon_msi.c        |  2 +-
>   arch/powerpc/platforms/cell/spider-pic.c      |  9 +++++---
>   arch/powerpc/platforms/pasemi/msi.c           |  6 ++++--
>   arch/powerpc/platforms/powernv/opal-irqchip.c |  2 +-
>   arch/powerpc/sysdev/ehv_pic.c                 |  3 ++-
>   arch/powerpc/sysdev/fsl_msi.c                 |  2 +-
>   arch/powerpc/sysdev/i8259.c                   |  3 ++-
>   arch/powerpc/sysdev/ipic.c                    |  3 ++-
>   arch/powerpc/sysdev/mpic.c                    |  3 ++-
>   arch/powerpc/sysdev/mpic_msi.c                |  2 +-
>   arch/powerpc/sysdev/qe_lib/qe_ic.c            |  3 ++-
>   drivers/gpio/gpio-sodaville.c                 |  2 +-
>   drivers/irqchip/exynos-combiner.c             |  2 +-
>   drivers/irqchip/irq-atmel-aic-common.c        |  2 +-
>   drivers/irqchip/irq-crossbar.c                |  4 ++--
>   drivers/irqchip/irq-gic-v2m.c                 |  2 +-
>   drivers/irqchip/irq-gic-v3-its.c              |  2 +-
>   drivers/irqchip/irq-gic-v3.c                  |  2 +-
>   drivers/irqchip/irq-gic.c                     |  2 +-
>   drivers/irqchip/irq-hip04.c                   |  2 +-
>   drivers/irqchip/irq-imx-gpcv2.c               |  2 +-
>   drivers/irqchip/irq-mtk-sysirq.c              |  2 +-
>   drivers/irqchip/irq-s3c24xx.c                 |  4 ++--
>   drivers/irqchip/irq-tegra.c                   |  4 ++--
>   drivers/irqchip/irq-vf610-mscm-ir.c           |  5 +++--
>   drivers/spmi/spmi-pmic-arb.c                  |  2 +-
>   include/linux/irqdomain.h                     |  5 +++++
>   kernel/irq/irqdomain.c                        | 30 +++++++++++++++++++--------
>   31 files changed, 74 insertions(+), 46 deletions(-)

Some missing files I noticed:
./arch/arm/mach-imx/gpc.c:	if (domain->of_node != controller)
./arch/arm/mach-imx/gpc.c:	parent_args.np = domain->parent->of_node;
./arch/arm/mach-exynos/suspend.c:	if (domain->of_node != controller)
./arch/arm/mach-exynos/suspend.c:	parent_args.np = domain->parent->of_node;

Thanks
Hanjun
