From: maciej.sosnowski@intel.com (Sosnowski, Maciej)
Date: Fri, 13 Nov 2009 15:09:00 +0000
Subject: [PATCH] Add COH 901 318 DMA block driver v4
In-Reply-To: <1257798973-11943-1-git-send-email-linus.walleij@stericsson.com>
References: <1257798973-11943-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <129600E5E5FB004392DDC3FB599660D7B7C11778@irsmsx504.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> This patch adds support for the ST-Ericsson COH 901 318 DMA block,
> found in the U300 series platforms. It registers a DMA slave for
> device I/O and also a memcpy slave for memcpy.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
> ChangeLog v3->v4
> - Removed the useless forward declaration of structs by arranging
>   #includes correctly. (Alan Cox)
> - NULL check ordering, exit on failure etc (Alan Cox)
> - Fixed a possible overflow in if statement. (Alan Cox)
> - Tag IO areas as __iomem (Alan Cox)
> - Check for base adresss NULL before operating on pointer on
>   several spots. (Alan Cox)
> - Removed dma_map() and dma_unmap() - clients shall do this.
>   (Maciej)
> - Add spin_unlock() in error path for coh901318_lli_fill_sg.
>   (Maciej)
> - Hope it is fine now!
> ---

Acked-by: Maciej Sosnowski <maciej.sosnowski@intel.com>
