From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 30 Sep 2016 15:04:04 +0530
Subject: [PATCH 2/6] ARM: dts: da850: add a node for the LCD controller
In-Reply-To: <1475166715-7857-3-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-3-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <4e0586e9-7f95-fbab-924a-fe046892a66b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 September 2016 10:01 PM, Bartosz Golaszewski wrote:
> From: Karl Beldan <kbeldan@baylibre.com>
> 
> Add a disabled LCDC node to be reused in device trees including
> da850.dtsi for boards equipped with tilcdc enabled.
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> [Bartosz: added the commit description]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index f79e1b9..9f39296 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -399,6 +399,14 @@
>  				<&edma0 0 1>;
>  			dma-names = "tx", "rx";
>  		};
> +
> +		lcdc: lcdc at 213000 {

node name should be generic per the ePAPR so please use "display".

> +			compatible = "ti,am33xx-tilcdc";

Can you please introduce a da850 specific compatible. Something like:

compatible = "ti,da850-tilcdc", "ti,am33xx-tilcdc";

Even if you dont use it in the driver today, please have it in the .dts
I am pretty sure there will be some da850 specific tweak required for
the LCDC at some point. Having a compatible already in place will make
migration easier. You will have to document the compatible though.

This will affect 1/6 too.

Thanks,
Sekhar
