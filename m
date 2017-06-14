From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 14 Jun 2017 13:34:19 +0100
Subject: [PATCH v2] arm64/dma-mapping: Remove extraneous null-pointer
 checks
In-Reply-To: <20170613205614.15872-1-ohaugan@codeaurora.org>
References: <20170613205614.15872-1-ohaugan@codeaurora.org>
Message-ID: <20170614123418.GB44176@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 01:56:14PM -0700, Olav Haugan wrote:
> The current null-pointer check in __dma_alloc_coherent and
> __dma_free_coherent is not needed anymore since the
> __dma_alloc/__dma_free functions won't be called if !dev (dummy ops will
> be called instead).
> 
> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
> ---
>  arch/arm64/include/asm/dma-mapping.h | 2 --
>  arch/arm64/mm/dma-mapping.c          | 9 ---------
>  2 files changed, 11 deletions(-)

Thanks.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Will should pick this up for 4.13

-- 
Catalin
