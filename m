From: eric@anholt.net (Eric Anholt)
Date: Wed, 17 Feb 2016 20:39:25 -0800
Subject: [PATCH V2 7/8] dmaengine: bcm2835: add slave_sg support to
 bcm2835-dma
In-Reply-To: <1452187987-2605-8-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-8-git-send-email-kernel@martin.sperl.org>
Message-ID: <87oabews1u.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Add slave_sg support to bcm2835-dma using shared allocation
> code for bcm2835_desc and DMA-control blocks already used by
> dma_cyclic.
>
> Note that bcm2835_dma_callback had to get modified to support
> both modes of operation (cyclic and non-cyclic).
>
> Tested using:
> * Hifiberry I2S card (using cyclic DMA)
> * fb_st7735r SPI-framebuffer (using slave_sg DMA via spi-bcm2835)
> playing BigBuckBunny for audio and video.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

I would have expected bcm2835_dma_create_cb_chain()'s changes to support
slave DMA to be in this patch rather than the refactor patch.  However,
the content of this one and 8/8 are:

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/9d8c8c3b/attachment.sig>
