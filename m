From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 14 Mar 2015 18:44:20 +0000
Subject: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
In-Reply-To: <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150314184420.GT21998@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 08:39:42PM +0800, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> ACPI kernel uses MADT table for proper GIC initialization. It needs to
> parse GIC related subtables, collect CPU interface and distributor
> addresses and call driver initialization function (which is hardware
> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> 
> NOTE: This commit allow to initialize GICv1/2 basic functionality.
> While now simple GICv2 init call is used, any further GIC features
> require generic infrastructure for proper ACPI irqchip initialization.
> That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
> extension, GICv3/4 and its ITS are considered as next steps.
> 
> CC: Jason Cooper <jason@lakedaemon.net>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h        |   2 +
>  arch/arm64/include/asm/irq.h         |  13 +++++
>  arch/arm64/kernel/acpi.c             |  25 +++++++++
>  drivers/irqchip/irq-gic.c            | 102 +++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irqchip.c            |   3 ++
>  include/linux/acpi_irq.h             |  10 ++++
>  include/linux/irqchip/arm-gic-acpi.h |  31 +++++++++++
>  7 files changed, 186 insertions(+)
>  create mode 100644 include/linux/acpi_irq.h
>  create mode 100644 include/linux/irqchip/arm-gic-acpi.h

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
