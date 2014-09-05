From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 05 Sep 2014 14:42:59 +0400
Subject: [PATCH v1 09/21] Irq_remapping/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
In-Reply-To: <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-10-git-send-email-wangyijing@huawei.com>
Message-ID: <540993B3.1000701@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 9/5/2014 2:09 PM, Yijing Wang wrote:

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>   drivers/iommu/irq_remapping.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)

> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 33c4395..e75026e 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
[...]
> @@ -165,9 +170,10 @@ static void __init irq_remapping_modify_x86_ops(void)
>   	x86_io_apic_ops.set_affinity	= set_remapped_irq_affinity;
>   	x86_io_apic_ops.setup_entry	= setup_ioapic_remapped_entry;
>   	x86_io_apic_ops.eoi_ioapic_pin	= eoi_ioapic_pin_remapped;
> -	x86_msi.setup_msi_irqs		= irq_remapping_setup_msi_irqs;
> +	x86_msi.setup_msi_irqs          = irq_remapping_setup_msi_irqs;

    AFAICS, this change only converts tabs to spaces, so not needed at all.

>   	x86_msi.setup_hpet_msi		= setup_hpet_msi_remapped;
>   	x86_msi.compose_msi_msg		= compose_remapped_msi_msg;
> +	x86_msi_chip = &remap_msi_chip;

    Please align = with the rest of assignments.

WBR, Sergei
