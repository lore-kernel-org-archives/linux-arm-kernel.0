From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 17 Nov 2009 11:36:36 -0500
Subject: [PATCH] ep93xx: add missing parentheses in IOMEM macro
In-Reply-To: <200911171249.22049.h.feurstein@gmail.com>
References: <200911171249.22049.h.feurstein@gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE551B@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 17, 2009 4:49 AM, Hubert Feurstein wrote:
>
> Signed-off-by: Hubert Feurstein <h.feurstein@gmail.com>
> ---
>  arch/arm/mach-ep93xx/include/mach/io.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/include/mach/io.h b/arch/arm/mach-ep93xx/include/mach/io.h
> index 594b77f..ddb6e32 100644
> --- a/arch/arm/mach-ep93xx/include/mach/io.h
> +++ b/arch/arm/mach-ep93xx/include/mach/io.h
> @@ -14,7 +14,7 @@
>   * A typesafe __io() variation for variable initialisers
>   */
>  #ifdef __ASSEMBLER__
> -#define IOMEM(p)		p
> +#define IOMEM(p)		(p)
>  #else
>  #define IOMEM(p)		((void __iomem __force *)(p))
>  #endif

I think the __ASSEMBLER__ version of the IOMEM macro is missing the
parentheses on purpose.

Maybe Russell can shed some light on this.

Regards,
Hartley
