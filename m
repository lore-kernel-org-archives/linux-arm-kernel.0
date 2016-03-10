From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Mar 2016 08:57:18 +0000
Subject: [PATCH v3 04/11] ARM: bcm2835: dt: add bindings for shared
 interrupt properties
In-Reply-To: <1457175142-28665-5-git-send-email-kernel@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
 <1457175142-28665-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160310085714.GA31313@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As a general note, please put DT bindings patches before any patches
implementing them, as per
Documentation/devicetree/bindings/submitting-patches.txt.

That makes it possible to review a series in-order.

On Sat, Mar 05, 2016 at 10:52:15AM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add binding documentation for the new shared interrupt properties:
> * brcm,dma-channel-shared-mask
> * brcm,dma-shared-irq-index
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> index 1396078..f9e84ee 100644
> --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> @@ -17,6 +17,10 @@ Required properties:
>  - brcm,dma-channel-mask: Bit mask representing the channels
>  			 not used by the firmware in ascending order,
>  			 i.e. first channel corresponds to LSB.
> +- brcm,dma-channel-shared-mask: Bit mask representing the channels
> +				that use a shared interrupt

Generally we don't like masks in DT (though I see this is in keeping with
another property above). I won't push strongly here.

I take it that this is a fixed HW property rather than a software configuration
option?

> +- brcm,dma-shared-irq-index: index of which of the interrupts mentioned
> +			     above is the shared interrupt

What is the usual order of the interrupts? How are they expected to be parsed
if this is in the middle of the list, for example?

I think this needs a more thorough description.

Thanks,
Mark.
