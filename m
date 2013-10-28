From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Oct 2013 23:15:38 +0000
Subject: [PATCH] ARM: head: Fix the missing underscore in __ARMEB__
 macro usage
In-Reply-To: <1382957121-10435-1-git-send-email-r.sricharan@ti.com>
References: <1382957121-10435-1-git-send-email-r.sricharan@ti.com>
Message-ID: <20131028231538.GK16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please send it to the patch system, thanks.

On Mon, Oct 28, 2013 at 04:15:21PM +0530, Sricharan R wrote:
> Commit 'f52bb722547f43caeaecbcc62db9f3c3b80ead9b'
> Author: Sricharan R <r.sricharan@ti.com>
>     ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses
> 
> introduced a __ARMEB__ macro usage in a new place, but missed the second
> underscore. So correcting it here.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  arch/arm/kernel/head.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 0f6c6d1..0fdd318f 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -555,7 +555,7 @@ ENTRY(fixup_smp)
>  	ldmfd	sp!, {r4 - r6, pc}
>  ENDPROC(fixup_smp)
>  
> -#ifdef __ARMEB_
> +#ifdef __ARMEB__
>  #define LOW_OFFSET	0x4
>  #define HIGH_OFFSET	0x0
>  #else
> -- 
> 1.7.9.5
> 
