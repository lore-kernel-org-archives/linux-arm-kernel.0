From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 01:07:31 -0700
Subject: [PATCH] ARM: prom.h: Fix build error by removing unneeded header
 file
In-Reply-To: <1325521143-29482-1-git-send-email-festevam@gmail.com>
References: <1325521143-29482-1-git-send-email-festevam@gmail.com>
Message-ID: <20120104080731.GD15503@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2012 at 02:19:03PM -0200, Fabio Estevam wrote:
> Fix the following build error:
> 
>   CC [M]  fs/udf/balloc.o
> In file included from /home/fabio/next/linux-next/arch/arm/include/asm/prom.h:16,
>                  from include/linux/of.h:140,
>                  from include/asm-generic/gpio.h:7,
>                  from arch/arm/plat-mxc/include/mach/irqs.h:14,
>                  from /home/fabio/next/linux-next/arch/arm/include/asm/irq.h:4,
>                  from /home/fabio/next/linux-next/arch/arm/include/asm/hardirq.h:6,
>                  from include/linux/hardirq.h:7,
>                  from include/linux/highmem.h:8,
>                  from include/linux/pagemap.h:10,
>                  from include/linux/buffer_head.h:13,
>                  from fs/udf/udfdecl.h:11,
>                  from fs/udf/balloc.c:22:
> /home/fabio/next/linux-next/arch/arm/include/asm/setup.h:146: error: redefinition of 'struct tag'
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Well that's ugly.  There are two definitions of struct tag.  The patch
does fix the compile error, but it could easily reoccur.  Ideally one
of the structures should be renamed.

Applied, thanks

g.

> ---
> This build error happens on linux-next by doing:
> make imx_v6_v7_defconfig
> make
> 
>  arch/arm/include/asm/prom.h |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/prom.h b/arch/arm/include/asm/prom.h
> index 6f65ca8..ee03633 100644
> --- a/arch/arm/include/asm/prom.h
> +++ b/arch/arm/include/asm/prom.h
> @@ -13,7 +13,6 @@
>  
>  #ifdef CONFIG_OF
>  
> -#include <asm/setup.h>
>  #include <asm/irq.h>
>  
>  extern struct machine_desc *setup_machine_fdt(unsigned int dt_phys);
> -- 
> 1.7.1
> 
