From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Feb 2016 20:18:24 -0800
Subject: [PATCH V2 4/8] dmaengine: bcm2835: add additional defines for
 DMA-registers
In-Reply-To: <1452187987-2605-5-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <87wpq2wt0v.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add additional defines describing the DMA registers
> as well as adding some more documentation to those registers.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  drivers/dma/bcm2835-dma.c |   54 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 46 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index 0c04236..7905327 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -99,26 +99,64 @@ struct bcm2835_desc {
>  
>  #define BCM2835_DMA_CS		0x00
>  #define BCM2835_DMA_ADDR	0x04
> +#define BCM2835_DMA_TI		0x08
>  #define BCM2835_DMA_SOURCE_AD	0x0c
>  #define BCM2835_DMA_DEST_AD	0x10
> -#define BCM2835_DMA_NEXTCB	0x1C
> +#define BCM2835_DMA_LEN		0x14
> +#define BCM2835_DMA_STIDE	0x18

s/STIDE/STRIDE/

With that fixed, and optionally Vinod's comment about reformatting the
comment changed,

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/6a256ca6/attachment.sig>
