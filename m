From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 15 Oct 2016 23:12:33 +0530
Subject: [PATCH 2/2] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <1475672732-17111-3-git-send-email-bgolaszewski@baylibre.com>
References: <1475672732-17111-1-git-send-email-bgolaszewski@baylibre.com>
 <1475672732-17111-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <2d276e51-9d37-8648-4aad-283bb2b23626@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 October 2016 06:35 PM, Bartosz Golaszewski wrote:
> From: Karl Beldan <kbeldan@baylibre.com>
> 
> Add pins used by the LCD controller and a disabled LCDC node to be
> reused in device trees including da850.dtsi.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> [Bartosz:
>   - added the commit description
>   - changed the dt node name to a generic one
>   - added a da850-specific compatible string
>   - removed the tilcdc,panel node
>   - moved the pins definitions to da850.dtsi as suggested by
>     Sekhar Nori (was in: da850-lcdk.dts)]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index f79e1b9..32908ae 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi

> @@ -399,6 +420,14 @@
>  				<&edma0 0 1>;
>  			dma-names = "tx", "rx";
>  		};
> +
> +		display: display at 213000 {
> +			compatible = "ti,am33xx-tilcdc", "ti,da850-tilcdc";

This should instead be:

compatible = "ti,da850-tilcdc", "ti,am33xx-tilcdc";

as the closest match should appear first in the list.

> +			reg = <0x213000 0x1000>;
> +			interrupt-parent = <&intc>

No need of specifying the interrupt-parent as it is assumed to be that
from the parent node (soc) if left unspecified.

I made these two fixes locally and pushed the two patches in this series
to v4.10/dt branch of my tree (for URL see MAINTAINERS). Can you take a
look and make sure I did not mess anything up?

Regards,
Sekhar
