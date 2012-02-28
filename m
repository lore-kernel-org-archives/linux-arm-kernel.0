From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Feb 2012 12:53:36 +0000
Subject: [PATCH] ARM: mx51: Fix build error due to missing include of
 <linux/bug.h>
In-Reply-To: <1330431110-22020-1-git-send-email-fabio.estevam@freescale.com>
References: <1330431110-22020-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120228125336.GA3617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 09:11:50AM -0300, Fabio Estevam wrote:
> Fix the following build error:
> 
> arch/arm/mach-imx/cpu_op-mx51.c: In function 'mx51_get_cpu_op':
> arch/arm/mach-imx/cpu_op-mx51.c:27: error: implicit declaration of function 'BUILD_BUG_ON_ZERO'

I think having the asm/bug.h replaced with linux/bug.h in linux/kernel.h
would be a better solution.

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> This applies against linux-next
> 
>  arch/arm/mach-imx/cpu_op-mx51.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cpu_op-mx51.c b/arch/arm/mach-imx/cpu_op-mx51.c
> index 9d34c3d..9a4f77a 100644
> --- a/arch/arm/mach-imx/cpu_op-mx51.c
> +++ b/arch/arm/mach-imx/cpu_op-mx51.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <mach/hardware.h>
>  #include <linux/kernel.h>
> +#include <linux/bug.h>
>  
>  static struct cpu_op mx51_cpu_op[] = {
>  	{
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
