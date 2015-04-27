From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 Apr 2015 16:48:01 +0800
Subject: [PATCH] ARM: imx: clk-cpu: Include "clk.h" header file
In-Reply-To: <1428013412-7082-1-git-send-email-festevam@gmail.com>
References: <1428013412-7082-1-git-send-email-festevam@gmail.com>
Message-ID: <20150427084800.GF9231@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 07:23:31PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Include the "clk.h" header file to fix the following sparse warning:
> 
> arch/arm/mach-imx/clk-cpu.c:77:12: warning: symbol 'imx_clk_cpu' was not declared. Should it be static?
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/clk-cpu.c | 2 ++

The file is being moved into drivers/clk/imx/.

Shawn

>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-cpu.c b/arch/arm/mach-imx/clk-cpu.c
> index aa1c345..a482e66 100644
> --- a/arch/arm/mach-imx/clk-cpu.c
> +++ b/arch/arm/mach-imx/clk-cpu.c
> @@ -13,6 +13,8 @@
>  #include <linux/clk-provider.h>
>  #include <linux/slab.h>
>  
> +#include "clk.h"
> +
>  struct clk_cpu {
>  	struct clk_hw	hw;
>  	struct clk	*div;
> -- 
> 1.9.1
> 
