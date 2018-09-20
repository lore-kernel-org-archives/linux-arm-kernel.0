From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 20 Sep 2018 10:07:17 +0100
Subject: [PATCH 1/5] ARM: make lookup_processor_type() non-__init
In-Reply-To: <E1g2Z6J-0003eJ-IY@rmk-PC.armlinux.org.uk>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
 <E1g2Z6J-0003eJ-IY@rmk-PC.armlinux.org.uk>
Message-ID: <f01027c1-b7df-b5b8-233c-a580139b0174@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 19/09/18 10:48, Russell King wrote:
> Move lookup_processor_type() out of the __init section so it is callable
> from (eg) the secondary startup code during hotplug.
> 

Reviewed-by: Julien Thierry <julien.thierry@arm.com>

> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>   arch/arm/kernel/head-common.S | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
> index 6e0375e7db05..997b02302c31 100644
> --- a/arch/arm/kernel/head-common.S
> +++ b/arch/arm/kernel/head-common.S
> @@ -145,6 +145,9 @@ ENDPROC(__mmap_switched)
>   #endif
>   	.size	__mmap_switched_data, . - __mmap_switched_data
>   
> +	__FINIT
> +	.text
> +
>   /*
>    * This provides a C-API version of __lookup_processor_type
>    */
> @@ -156,9 +159,6 @@ ENTRY(lookup_processor_type)
>   	ldmfd	sp!, {r4 - r6, r9, pc}
>   ENDPROC(lookup_processor_type)
>   
> -	__FINIT
> -	.text
> -
>   /*
>    * Read processor ID register (CP#15, CR0), and look up in the linker-built
>    * supported processor list.  Note that we can't use the absolute addresses
> 

-- 
Julien Thierry
