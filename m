From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Mar 2017 16:37:22 -0500
Subject: [PATCH 3/5] dt-bindings: stm32-dma: Add property to handle STM32
 DMAMUX
In-Reply-To: <1489414561-28912-4-git-send-email-cedric.madianga@gmail.com>
References: <1489414561-28912-1-git-send-email-cedric.madianga@gmail.com>
 <1489414561-28912-4-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20170320213722.oj3ipmslbw2mp27d@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 13, 2017 at 03:15:59PM +0100, M'boumba Cedric Madianga wrote:
> This patch adds an optional property needed for STM32 DMA controller
> addressed via STM32 DMAMUX.
> 
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/stm32-dma.txt b/Documentation/devicetree/bindings/dma/stm32-dma.txt
> index 4408af6..7b5e91a 100644
> --- a/Documentation/devicetree/bindings/dma/stm32-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/stm32-dma.txt
> @@ -16,6 +16,9 @@ Optional properties:
>  - resets: Reference to a reset controller asserting the DMA controller
>  - st,mem2mem: boolean; if defined, it indicates that the controller supports
>    memory-to-memory transfer
> +- st,dmamux: boolean; if defined, it indicates that the controller is behind a
> +  DMA multiplexer. In that case, using dma instances doesn't work for DMA
> +  clients. They have to use dma-router instances.

This should not be needed for the same reason we don't need anything 
like this for chained interrupt controllers.

Also, the compatible string should be specific enough to provide this 
information.

Rob
