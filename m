From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 06 May 2010 13:35:43 -0400 (EDT)
Subject: [PATCH] ARM: Declare __copy_to_user_std as a function using
	ENDPROC
In-Reply-To: <20100506141238.4396.8055.stgit@e102109-lin.cambridge.arm.com>
References: <20100506141238.4396.8055.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1005061334190.14468@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 May 2010, Catalin Marinas wrote:

> This is needed for Thumb-2 kernel builds, otherwise the compiler
> generates branches into ARM mode to this function.
> 
> Reported-by: Kyungmin Park <kmpark@infradead.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

You need to do the same with __clear_user_std as well.  With that change 
added:

Acked-by: Nicolas Pitre <nico@fluxnic.net>




> ---
>  arch/arm/lib/copy_to_user.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
> index 1a71e15..5941fbc 100644
> --- a/arch/arm/lib/copy_to_user.S
> +++ b/arch/arm/lib/copy_to_user.S
> @@ -93,6 +93,7 @@ WEAK(__copy_to_user)
>  #include "copy_template.S"
>  
>  ENDPROC(__copy_to_user)
> +ENDPROC(__copy_to_user_std)
>  
>  	.section .fixup,"ax"
>  	.align 0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
