From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 Jan 2016 19:08:45 -0800
Subject: [PATCH V2 2/8] dmaengine: bcm2835: remove unnecessary masking of
 dma channels
In-Reply-To: <1452187987-2605-3-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <8737tflq6a.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> The original patch contained 3 dma channels that were masked out.
>
> These - as far as research and discussions show - are a
> artefacts remaining from the downstream legacy dma-api.
>
> Right now down-stream still includes a legacy api used only
> in a single (downstream only) driver (bcm2708_fb) that requires
> 2D DMA for speedup (DMA-channel 0).
> Formerly the sd-card support driver also was using this legacy
> api (DMA-channel 2), but since has been moved over to use
> dmaengine directly.
>
> The DMA-channel 3 is already masked out in the devicetree in
> the default property "brcm,dma-channel-mask = <0x7f35>;"

Delayed the rest of the review, because I went digging around in the
firmware, and missed the ifdef mess in it that produced 0x7f35.  As far
as I can tell, though, we should be using just that value to control
which channels we expose (other than the shared-irq issue).  If the
firmware wants to use a different set of channels some day, they'll have
to edit our DT.

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/8188ea20/attachment-0001.sig>
