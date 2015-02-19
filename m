From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 19 Feb 2015 11:17:33 -0600
Subject: [PATCH] arm: socfpga: Correct SCU virtual mapping in socfpga
In-Reply-To: <1423679665-19545-1-git-send-email-vbridger@opensource.altera.com>
References: <1423679665-19545-1-git-send-email-vbridger@opensource.altera.com>
Message-ID: <alpine.DEB.2.02.1502191116400.20048@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Feb 2015, Vince Bridgers wrote:

> Correct SCU virtual mapping that was causing this BUG message:
> 
> "BUG: mapping for 0xfffec000 at 0xfffec000 out of vmalloc space"
> 
> Signed-off-by: Vince Bridgers <vbridger@opensource.altera.com>
> ---
>  arch/arm/mach-socfpga/core.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
> index 483cb46..a0f3b1c 100644
> --- a/arch/arm/mach-socfpga/core.h
> +++ b/arch/arm/mach-socfpga/core.h
> @@ -45,6 +45,6 @@ extern char secondary_trampoline, secondary_trampoline_end;
>  
>  extern unsigned long socfpga_cpu1start_addr;
>  
> -#define SOCFPGA_SCU_VIRT_BASE   0xfffec000
> +#define SOCFPGA_SCU_VIRT_BASE   0xfee00000
>  
>  #endif

Applied to fixes.

BR,
Dinh
