From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 17 Jun 2013 16:31:24 +0530
Subject: [PATCH v10 5/8] dmaengine: edma: Add TI EDMA device tree binding
In-Reply-To: <1371263570-9323-5-git-send-email-joelagnel@ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
 <1371263570-9323-5-git-send-email-joelagnel@ti.com>
Message-ID: <51BEEC84.1080102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant, Rob,

Can one of you please take a look at this patch and see if you have any
comments on the binding definition?

Joel,

Ideally the bindings are described before they are used or along with
its usage. In that aspect, this patch is present too far back in the
series. Can you please fix this if you get to posting another version. I
think I gave the same comment on v9 as well.

On 6/15/2013 8:02 AM, Joel A Fernandes wrote:
> From: Matt Porter <mdp@ti.com>
> 
> The binding definition is based on the generic DMA controller
> binding.
> 
> Joel: Droped reserved and queue DT entries from Documentation
> for now from the original patch series.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Signed-off-by: Joel A Fernandes <joelagnel@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt |   26 +++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> new file mode 100644
> index 0000000..ada0018
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -0,0 +1,26 @@
> +TI EDMA
> +
> +Required properties:
> +- compatible : "ti,edma3"
> +- ti,hwmods: Name of the hwmods associated to the EDMA

ti,hwmods should be optional, no? hwmod is not present on DaVinci where
EDMA is also used. If it is not optional then these bindings wont work
there.

Thanks,
Sekhar
