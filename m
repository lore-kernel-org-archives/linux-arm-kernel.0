From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Feb 2014 09:40:20 +0100
Subject: [PATCH] arm: removed compiler warning
In-Reply-To: <20140217043834.GA7563@vega.jjdev.com>
References: <20140217043834.GA7563@vega.jjdev.com>
Message-ID: <530710F4.6060804@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/02/2014 05:38, John de la Garza wrote:
> Removed this compiler warning for arch/arm/boot/compressed/atags_to_fdt.c.
> The warning was: 'memsize' may be used uninitialized in this function.
> 

Indeed it was an error, thanks to have fixed it.

> Signed-off-by: John de la Garza <john@jjdev.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

> ---
>  arch/arm/boot/compressed/atags_to_fdt.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
> index d1153c8..75b64da 100644
> --- a/arch/arm/boot/compressed/atags_to_fdt.c
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -110,7 +110,8 @@ int atags_to_fdt(void *atag_list, void *fdt, int total_space)
>  	 * address and size for each bank */
>  	uint32_t mem_reg_property[2 * 2 * NR_BANKS];
>  	int memcount = 0;
> -	int ret, memsize;
> +	int memsize = 0;
> +	int ret;
>  
>  	/* make sure we've got an aligned pointer */
>  	if ((u32)atag_list & 0x3)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
