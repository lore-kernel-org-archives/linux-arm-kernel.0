From: ben@decadent.org.uk (Ben Hutchings)
Date: Fri, 08 Apr 2011 00:47:44 +0100
Subject: [PATCH] arm: Fix .size directive for xscale_dma_a0_map_area
In-Reply-To: <1299900442.4146.79.camel@localhost>
References: <1299900442.4146.79.camel@localhost>
Message-ID: <1302220064.5282.10.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2011-03-12 at 03:27 +0000, Ben Hutchings wrote:
> gas used to accept (and ignore?) .size directives which referred to
> undefined symbols, as this does.  In binutils 2.21 these are treated
> as fatal errors.

Please acknowledge and send this upstream.

You also haven't responded to my patch fixing .size directives for
__arm{7,9}tdmi_proc_info.

Ben.

> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> I missed this one previously because my 5-minute script didn't recognise
> the ENDPROC macro as generating a .size directive.
> 
> Ben.
> 
>  arch/arm/mm/proc-xscale.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
> index 5a37c5e..ab00b59 100644
> --- a/arch/arm/mm/proc-xscale.S
> +++ b/arch/arm/mm/proc-xscale.S
> @@ -395,7 +395,7 @@ ENTRY(xscale_dma_a0_map_area)
>  	teq	r2, #DMA_TO_DEVICE
>  	beq	xscale_dma_clean_range
>  	b	xscale_dma_flush_range
> -ENDPROC(xscsale_dma_a0_map_area)
> +ENDPROC(xscale_dma_a0_map_area)
>  
>  /*
>   *	dma_unmap_area(start, size, dir)

-- 
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110408/e0707e03/attachment.sig>
