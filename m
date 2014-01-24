From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jan 2014 15:37:56 +0000
Subject: [PATCH] arm64: fix build error if DMA_CMA is enabled
In-Reply-To: <1390551788-6138-1-git-send-email-pankaj.dubey@samsung.com>
References: <1390551788-6138-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140124153756.GH19052@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 08:23:08AM +0000, Pankaj Dubey wrote:
> arm64/include/asm/dma-contiguous.h is trying to include
> <asm-genric/dma-contiguous.h> which does not exist, and thus failing
> build for arm64 if we enable CONFIG_DMA_CMA. This patch fixes build 
> error by removing unwanted header inclusion from arm64's dma-contiguous.h.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Somraj Mani <somraj.mani@samsung.com>
> ---
>  arch/arm64/include/asm/dma-contiguous.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/dma-contiguous.h b/arch/arm64/include/asm/dma-contiguous.h
> index d6aacb6..14c4c0c 100644
> --- a/arch/arm64/include/asm/dma-contiguous.h
> +++ b/arch/arm64/include/asm/dma-contiguous.h
> @@ -18,7 +18,6 @@
>  #ifdef CONFIG_DMA_CMA
>  
>  #include <linux/types.h>
> -#include <asm-generic/dma-contiguous.h>

Thanks for this.

Laura, did you have additional patches adding
asm-generic/dma-contiguous.h?

-- 
Catalin
