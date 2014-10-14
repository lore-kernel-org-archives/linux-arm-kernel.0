From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Oct 2014 10:43:10 +0100
Subject: [PATCH 2/2] ARM64: Add printf annotation to early_print
In-Reply-To: <1413277169-6941-2-git-send-email-alexander.stein@systec-electronic.com>
References: <1413277169-6941-1-git-send-email-alexander.stein@systec-electronic.com>
 <1413277169-6941-2-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20141014094309.GC26987@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 09:59:29AM +0100, Alexander Stein wrote:
> This adds the printf format annotation to early_print to warn users about
> incompatible formats and argument.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
>  arch/arm64/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index edb146d..bbf633b 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -102,7 +102,7 @@ static struct resource mem_res[] = {
>  #define kernel_code mem_res[0]
>  #define kernel_data mem_res[1]
>  
> -void __init early_print(const char *str, ...)
> +void __init __printf(1, 2) early_print(const char *str, ...)
>  {
>  	char buf[256];
>  	va_list ap;

I wonder if we need this function at all on arm64. Early on, we used
something similar to the 32-bit ARM printascii but with an early console
now, we go through the printk anyway so I think we can just remove this
function (it has a single caller anyway on arm64).

-- 
Catalin
