From: guohanjun@huawei.com (Hanjun Guo)
Date: Wed, 25 Mar 2015 21:23:55 +0800
Subject: [PATCH 1/5] ACPI: move arm64 GSI IRQ model to generic GSI IRQ
 layer
In-Reply-To: <1427219940-27201-2-git-send-email-lorenzo.pieralisi@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5512B6EB.9060802@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/25 1:58, Lorenzo Pieralisi wrote:
> The code deployed to implement GSI linux IRQ numbers mapping on arm64 turns
> out to be generic enough so that it can be moved to ACPI core code along
> with its respective config option ACPI_GENERIC_GSI selectable on
> architectures that can reuse the same code.
>
> Current ACPI IRQ mapping code is not integrated in the kernel IRQ domain
> infrastructure, in particular there is no way to look-up the
> IRQ domain associated with a particular interrupt controller, so this
> first version of GSI generic code carries out the GSI<->IRQ mapping relying
> on the IRQ default domain which is supposed to be always set on a
> specific architecture in case the domain structure passed to
> irq_create/find_mapping() functions is missing.
>
> This patch moves the arm64 acpi functions that implement the gsi mappings:
>
> acpi_gsi_to_irq()
> acpi_register_gsi()
> acpi_unregister_gsi()
>
> to ACPI core code. Since the generic GSI<->domain mapping is based on IRQ
> domains, it can be extended as soon as a way to map an interrupt
> controller to an IRQ domain is implemented for ACPI in the IRQ domain
> layer.
>
> x86 and ia64 code for GSI mappings cannot rely on the generic GSI
> layer at present for legacy reasons, so they do not select the
> ACPI_GENERIC_GSI config options and keep relying on their arch
> specific GSI mapping layer.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
