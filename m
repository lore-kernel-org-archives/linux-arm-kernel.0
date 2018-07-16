From: vbabka@suse.cz (Vlastimil Babka)
Date: Mon, 16 Jul 2018 09:45:31 +0200
Subject: [PATCH 2/2] dma: remove unsupported gfp_mask parameter from
 dma_alloc_from_contiguous()
In-Reply-To: <20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y@eucas1p2.samsung.com>
References: <20180709121956.20200-1-m.szyprowski@samsung.com>
 <CGME20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1@eucas1p2.samsung.com>
 <20180709122020eucas1p21a71b092975cb4a3b9954ffc63f699d1~-sqUFoa-h2939329393eucas1p2Y@eucas1p2.samsung.com>
Message-ID: <c4380664-e9c2-f366-f776-f24af8a42f27@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2018 02:19 PM, Marek Szyprowski wrote:
> The CMA memory allocator doesn't support standard gfp flags for memory
> allocation, so there is no point having it as a parameter for
> dma_alloc_from_contiguous() function. Replace it by a boolean no_warn
> argument, which covers all the underlaying cma_alloc() function supports.
> 
> This will help to avoid giving false feeling that this function supports
> standard gfp flags and callers can pass __GFP_ZERO to get zeroed buffer,
> what has already been an issue: see commit dd65a941f6ba ("arm64:
> dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag").
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
