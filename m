From: robert.richter@cavium.com (Robert Richter)
Date: Thu, 27 Jul 2017 10:57:15 +0200
Subject: [PATCH] irqchip/gic-v3-its: Remove ACPICA version check for ACPI
 NUMA
In-Reply-To: <20170712132509.11281-1-rrichter@cavium.com>
References: <20170712132509.11281-1-rrichter@cavium.com>
Message-ID: <20170727085715.GJ17961@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

I think this can go in as fix for 4.13.

Please review. Thanks,

-Robert

On 12.07.17 15:25:09, Robert Richter wrote:
> The version check was added due to dependency to
> 
>  a618c7f89a02 ACPICA: Add support for new SRAT subtable
> 
> Now, that this code is in the kernel, remove the check. This is esp.
> useful to enable backports.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index bb33ba1837a9..745c5772e99b 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -1858,7 +1858,7 @@ static int __init its_of_probe(struct device_node *node)
>  
>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
>  
> -#if defined(CONFIG_ACPI_NUMA) && (ACPI_CA_VERSION >= 0x20170531)
> +#ifdef CONFIG_ACPI_NUMA
>  struct its_srat_map {
>  	/* numa node id */
>  	u32	numa_node;
> -- 
> 2.11.0
> 
