From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Jan 2014 09:24:16 +0100
Subject: [patch] ARM: mvebu: checking for IS_ERR() instead of NULL
In-Reply-To: <20140121065216.GA31535@elgon.mountain>
References: <20140121065216.GA31535@elgon.mountain>
Message-ID: <52DE2EB0.9010206@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/01/2014 07:52, Dan Carpenter wrote:
> of_iomap() returns NULL on error, it doesn't return error pointers.
>

Hi Dan,

Thanks for your patch but I already sent this fix yesterday and Jason have
applied. See: http://thread.gmane.org/gmane.linux.ports.arm.kernel/295642


Thanks,

Gregory



> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
> index fe4fc1cbdfaf..b4cfbd62709d 100644
> --- a/arch/arm/mach-mvebu/mvebu-soc-id.c
> +++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
> @@ -88,7 +88,7 @@ static int __init mvebu_soc_id_init(void)
>  	}
>  
>  	pci_base = of_iomap(child, 0);
> -	if (IS_ERR(pci_base)) {
> +	if (!pci_base) {
>  		pr_err("cannot map registers\n");
>  		ret = -ENOMEM;
>  		goto res_ioremap;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
