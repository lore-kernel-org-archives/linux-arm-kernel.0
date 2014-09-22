From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Sep 2014 21:45:40 +0200
Subject: [PATCH] mfd: inherit coherent_dma_mask from parent device
In-Reply-To: <1411414675-19010-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1411414675-19010-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <12718317.Y05azLtl8v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014 21:37:55 Boris BREZILLON wrote:
> dma_mask and dma_parms are already inherited from the parent device but
> dma_coherent_mask was left uninitialized (set to zero thanks to kzalloc).
> Set sub-device coherent_dma_mask to its parent value to simplify
> sub-drivers making use of dma coherent helper functions (those drivers
> currently have to explicitly set the dma coherent mask using
> dma_set_coherent_mask function).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
> 
> Hi,
> 
> This patch is follow-up of a discussion we had on a KMS driver thread [1].
> This patch is only copying the parent device coherent_dma_mask to avoid
> calling specific dma_set_coherent_mask in case the coherent mask is the
> default one.
> 
> I'm a bit surprised this hasn't been done earlier while other dma fields
> (mask and parms) are already inherited from the parent device, so please
> tell me if there already was an attempt to do the same, and if so, what
> was the reson for rejecting it :-).
> 
> 

Seems reasonable to me. It's not clear whether we should always inherit
the dma_mask, but I see no point in copying just dma_mask but not
coherent_dma_mask.

Acked-by: Arnd Bergmann <arnd@arndb.de>
