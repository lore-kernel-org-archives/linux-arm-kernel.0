From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 18 Nov 2011 15:23:22 +0000
Subject: [PATCH v2] fix compilation breakage in entry-armv.S
In-Reply-To: <Pine.LNX.4.64.1111161602510.3881@axis700.grange>
References: <Pine.LNX.4.64.1111081232140.10851@axis700.grange>
 <20111108114050.GC12913@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1111081258240.10851@axis700.grange>
 <20111111151515.GA3099@localhost.localdomain>
 <Pine.LNX.4.64.1111161602510.3881@axis700.grange>
Message-ID: <20111118152321.GA30405@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 04:05:04PM +0100, Guennadi Liakhovetski wrote:
> Fix compilation failure, when Thumb support is not enabled:
> 
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:501: Error: backward ref to unknown label "2:"
> arch/arm/kernel/entry-armv.S:502: Error: backward ref to unknown label "3:"
> make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

That looks fine to me.

If Russell is OK with this, please send the patch to his patch system
so we can get this merged.

Reviewed-by: Dave Martin <dave.martin@linaro.org>

> v2: use exactly the same preprocessor condition, as the one used for the 
> code, defining labels "2" and "3"
> 
>  arch/arm/kernel/entry-armv.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 9ad50c4..b145f16 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -497,7 +497,7 @@ ENDPROC(__und_usr)
>  	.popsection
>  	.pushsection __ex_table,"a"
>  	.long	1b, 4b
> -#if __LINUX_ARM_ARCH__ >= 7
> +#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7
>  	.long	2b, 4b
>  	.long	3b, 4b
>  #endif
> -- 
> 1.7.2.5
> 
