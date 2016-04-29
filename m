From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 29 Apr 2016 14:13:25 -0700
Subject: [PATCH 2/5] dmaengine: vdma: Use dma_pool_zalloc
In-Reply-To: <1461960552-7429-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
 <1461960552-7429-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160429211325.GB3766@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-04-29 at 22:09:09 +0200, Julia Lawall wrote:
> Dma_pool_zalloc combines dma_pool_alloc and memset 0.  The semantic patch
> that makes this transformation is as follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression d,e;
> statement S;
> @@
> 
>         d =
> -            dma_pool_alloc
> +            dma_pool_zalloc
>              (...);
>         if (!d) S
> -       memset(d, 0, sizeof(*d));
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
