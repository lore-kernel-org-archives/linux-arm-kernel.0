From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 01:02:38 +0100
Subject: [PATCH 1/3] s3c64xx: Fix S3C64XX_CLKDIV0_ARM_MASK value
In-Reply-To: <30516562.529311252139253359.JavaMail.weblogic@epml18>
References: <30516562.529311252139253359.JavaMail.weblogic@epml18>
Message-ID: <20090916000238.GK13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2009 at 08:27:33AM +0000, Kukjin Kim wrote:
> 
> The value of S3C64XX_CLKDIV0_ARM_MASK is wrong. This patch fixes                                
> this values, S3C6400_CLKDIV0_ARM_MASK and S3C6410_CLKDIV0_ARM_MASK.                             
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>                                               
> ---     
>  arch/arm/plat-s3c64xx/include/plat/regs-clock.h |    4 ++--                                    
>  1 files changed, 2 insertions(+), 2 deletions(-)                                               
> 
> diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> index a8777a7..ff46e7f 100644                                                                   
> --- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h                                           
> +++ b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
> @@ -51,8 +51,8 @@
>  #define S3C6400_CLKDIV0_HCLK_SHIFT     (8)                                                     
>  #define S3C6400_CLKDIV0_MPLL_MASK      (0x1 << 4)                                              
>  #define S3C6400_CLKDIV0_MPLL_SHIFT     (4)                                                     
> -#define S3C6400_CLKDIV0_ARM_MASK       (0x3 << 0)                                              
> -#define S3C6410_CLKDIV0_ARM_MASK       (0x7 << 0)                                              
> +#define S3C6400_CLKDIV0_ARM_MASK       (0x7 << 0)
> +#define S3C6410_CLKDIV0_ARM_MASK       (0xf << 0)                                              
This looks ok, please re-post without the extra whitespace.

>  #define S3C6400_CLKDIV0_ARM_SHIFT      (0)                                                     
>  
>  /* CLKDIV1 */                                                                                  
> -- 
> 1.5.3.4
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
