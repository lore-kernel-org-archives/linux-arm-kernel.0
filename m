From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 5 Sep 2018 15:27:29 +0200
Subject: [PATCH] ARM: zynq: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-3-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-3-robh@kernel.org>
Message-ID: <147b3be7-805f-a0af-8da5-04f257d2b919@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.8.2018 03:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/mach-zynq/slcr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index f0292a30e6f6..10ef99ce1d90 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -233,7 +233,7 @@ int __init zynq_early_slcr_init(void)
>  
>  	register_restart_handler(&zynq_slcr_restart_nb);
>  
> -	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);
> +	pr_info("%pOFn mapped to %p\n", np, zynq_slcr_base);
>  
>  	of_node_put(np);
>  
> 

Applied.
M
