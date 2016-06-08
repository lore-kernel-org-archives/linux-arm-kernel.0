From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Jun 2016 09:05:15 +0530
Subject: [PATCH] dmaengine: xilinx_vdma: Use dma_pool_zalloc
In-Reply-To: <20160607191838.GA26841@amitoj-Inspiron-3542>
References: <20160607191838.GA26841@amitoj-Inspiron-3542>
Message-ID: <20160608033514.GR16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 12:48:38AM +0530, Amitoj Kaur Chawla wrote:
> Dma_pool_zalloc combines dma_pool_alloc and memset 0.
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> type T;
> T *d;
> expression e;
> statement S;
> @@
> 
>         d =
> -            dma_pool_alloc
> +            dma_pool_zalloc
>              (...);
>         if (!d) S
> -       memset(d, 0, sizeof(T));

Thanks for your patch, but I have already applied a similar patch fixing
this.

-- 
~Vinod
