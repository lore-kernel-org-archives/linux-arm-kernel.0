From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 13 Jan 2012 14:24:15 +0000
Subject: [PATCH v2 3/7] ARM: ux500: add missing ENDPROC to headsmp.S
In-Reply-To: <1326389476-11569-4-git-send-email-robherring2@gmail.com>
References: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
 <1326389476-11569-4-git-send-email-robherring2@gmail.com>
Message-ID: <20120113142415.GD2227@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 11:31:12AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Once the ENDPROC is in place, BSYM() in not longer necessary
> to get correct pointer to u8500_secondary_startup().
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@stericsson.com>

The words at label 1 may be misaligned in a Thumb kernel, which is
undesirable.

It probably makes sense to add a .align 2 before that label
as part of this patch.

Cheers
---Dave

> ---
>  arch/arm/mach-ux500/headsmp.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
> index 64fa451..d03843d 100644
> --- a/arch/arm/mach-ux500/headsmp.S
> +++ b/arch/arm/mach-ux500/headsmp.S
> @@ -32,6 +32,7 @@ pen:	ldr	r7, [r6]
>  	 * should now contain the SVC stack for this core
>  	 */
>  	b	secondary_startup
> +ENDPROC(u8500_secondary_startup)
>  
>  1:	.long	.
>  	.long	pen_release
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
