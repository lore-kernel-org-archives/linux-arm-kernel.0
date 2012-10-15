From: markus@oberhumer.com (Markus F.X.J. Oberhumer)
Date: Mon, 15 Oct 2012 16:32:55 +0200
Subject: [PATCH] lib: decompress_unlzo: Change include file name
In-Reply-To: <1350238390-1549-1-git-send-email-festevam@gmail.com>
References: <1350238390-1549-1-git-send-email-festevam@gmail.com>
Message-ID: <507C1E97.3020006@oberhumer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Fabio,

that should already be fixed on the "lzo-update" branch at

  git://github.com/markus-oberhumer/linux.git lzo-update

Cheers,
Markus

On 2012-10-14 20:13, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Commit 7c979cebc (lib/lzo: Rename lzo1x_decompress.c to lzo1x_decompress_safe.c) 
> renamed lzo1x_decompress.c file, but missed to update lib/decompress_unlzo.c,
> which breaks imx_v6_v7_defconfig build:
> 
> arch/arm/boot/compressed/../../../../lib/decompress_unlzo.c:34:34: fatal error: lzo/lzo1x_decompress.c: No such file or directory
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  lib/decompress_unlzo.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/decompress_unlzo.c b/lib/decompress_unlzo.c
> index 4531294..960183d 100644
> --- a/lib/decompress_unlzo.c
> +++ b/lib/decompress_unlzo.c
> @@ -31,7 +31,7 @@
>   */
>  
>  #ifdef STATIC
> -#include "lzo/lzo1x_decompress.c"
> +#include "lzo/lzo1x_decompress_safe.c"
>  #else
>  #include <linux/decompress/unlzo.h>
>  #endif

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
