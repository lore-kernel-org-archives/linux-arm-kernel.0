From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 23 Mar 2015 22:18:04 -0700
Subject: [PATCH] ARM: cygnus: fix const declaration bcm_cygnus_dt_compat
In-Reply-To: <1426981535-1800-1-git-send-email-stefan@agner.ch>
References: <1426981535-1800-1-git-send-email-stefan@agner.ch>
Message-ID: <5510F38C.6090501@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 15-03-21 04:45 PM, Stefan Agner wrote:
> The const declaration for char* is actually duplicated, however
> the array of strings is currently not constant. However, typically
> the dt_compat array is declared as const char *const. Follow
> that convention and also add the __initconst macro for constant
> initialization data.
>
Acked-by: Scott Branden <sbranden@broadcom.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> This was uncovered by a LLVM/clang warning:
> arch/arm/mach-bcm/bcm_cygnus.c:16:19: warning: duplicate 'const' declaration
> specifier [-Wduplicate-decl-specifier]
> static const char const *bcm_cygnus_dt_compat[] = {
>                    ^~~~~~
> 1 warning generated.
>
>   arch/arm/mach-bcm/bcm_cygnus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-bcm/bcm_cygnus.c b/arch/arm/mach-bcm/bcm_cygnus.c
> index 30dc58b..7ae894c 100644
> --- a/arch/arm/mach-bcm/bcm_cygnus.c
> +++ b/arch/arm/mach-bcm/bcm_cygnus.c
> @@ -13,7 +13,7 @@
>
>   #include <asm/mach/arch.h>
>
> -static const char const *bcm_cygnus_dt_compat[] = {
> +static const char * const bcm_cygnus_dt_compat[] __initconst = {
>   	"brcm,cygnus",
>   	NULL,
>   };
>
Thanks for submitting.  We will test this.

Scott
