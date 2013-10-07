From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 7 Oct 2013 15:42:21 -0400 (EDT)
Subject: [PATCH v3 4/6] ARM: mm: Correct virt_to_phys patching for 64
 bit physical addresses
In-Reply-To: <52530A98.1030708@ti.com>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
 <1380835081-12129-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1310031952060.3023@syhkavp.arg> <524E541D.2030509@ti.com>
 <alpine.LFD.2.03.1310040857530.3023@syhkavp.arg>
 <52530A98.1030708@ti.com>
Message-ID: <alpine.LFD.2.03.1310071537040.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013, Santosh Shilimkar wrote:

> Update patch below with your review tag for records.
> 
> Regards,
> Santosh

Micronit:

>  	.data
>  	.globl	__pv_phys_offset
>  	.type	__pv_phys_offset, %object
>  __pv_phys_offset:
> -	.long	0
> -	.size	__pv_phys_offset, . - __pv_phys_offset
> +	.quad	0
> +
> +	.data
> +	.globl	__pv_offset
> +	.type	__pv_offset, %object
>  __pv_offset:
> -	.long	0
> +	.quad	0

Please keep the .size statement for __pv_phys_offset, and adding one for 
__pv_offset wouldn't hurt either.  And the second .data is redundant.


Nicolas
