From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 24 Jul 2015 16:54:29 +0800
Subject: [PATCH v2 1/7] genirq: irqdomain: Use an accessor for the of_node
 field
In-Reply-To: <1437656713-9677-2-git-send-email-marc.zyngier@arm.com>
References: <1437656713-9677-1-git-send-email-marc.zyngier@arm.com>
 <1437656713-9677-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <55B1FD45.4060706@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 09:05 PM, Marc Zyngier wrote:
> The struct irq_domain contains a "struct device_node *" field
> (of_node) that is almost the only link between the irqdomain
> and the device tree infrastructure.
>
> In order to prepare for the removal of that field, convert all
> users outside of kernel/irq/irqdomain.c to use an accessor.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/c6x/platforms/megamod-pic.c              | 2 +-
>   arch/mips/cavium-octeon/octeon-irq.c          | 4 ++--
>   arch/powerpc/platforms/cell/axon_msi.c        | 2 +-
>   arch/powerpc/platforms/cell/spider-pic.c      | 9 ++++++---
>   arch/powerpc/platforms/pasemi/msi.c           | 6 ++++--
>   arch/powerpc/platforms/powernv/opal-irqchip.c | 2 +-
>   arch/powerpc/sysdev/ehv_pic.c                 | 3 ++-
>   arch/powerpc/sysdev/fsl_msi.c                 | 2 +-
>   arch/powerpc/sysdev/i8259.c                   | 3 ++-
>   arch/powerpc/sysdev/ipic.c                    | 3 ++-
>   arch/powerpc/sysdev/mpic.c                    | 3 ++-
>   arch/powerpc/sysdev/mpic_msi.c                | 2 +-
>   arch/powerpc/sysdev/qe_lib/qe_ic.c            | 3 ++-

Hmm, no arch/arm/, and there are several domain->of_node
or similar in those files, or did I miss something?

>   drivers/gpio/gpio-sodaville.c                 | 2 +-
>   drivers/irqchip/exynos-combiner.c             | 2 +-
>   drivers/irqchip/irq-atmel-aic-common.c        | 2 +-
>   drivers/irqchip/irq-crossbar.c                | 4 ++--
>   drivers/irqchip/irq-gic-v2m.c                 | 2 +-
>   drivers/irqchip/irq-gic-v3-its.c              | 2 +-
>   drivers/irqchip/irq-gic-v3.c                  | 2 +-
>   drivers/irqchip/irq-gic.c                     | 2 +-
>   drivers/irqchip/irq-hip04.c                   | 2 +-
>   drivers/irqchip/irq-mtk-sysirq.c              | 2 +-
>   drivers/irqchip/irq-s3c24xx.c                 | 4 ++--
>   drivers/irqchip/irq-tegra.c                   | 4 ++--
>   drivers/irqchip/irq-vf610-mscm-ir.c           | 5 +++--
>   drivers/spmi/spmi-pmic-arb.c                  | 2 +-
>   include/linux/irqdomain.h                     | 5 +++++
>   28 files changed, 51 insertions(+), 35 deletions(-)
>


Thanks
Hanjun
