From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 16 Jun 2016 11:49:07 +0200
Subject: [PATCH 3/5] clk: max77686: Add DT binding details for PMIC
 MAX77620
In-Reply-To: <1466000018-16784-4-git-send-email-ldewangan@nvidia.com>
References: <1466000018-16784-1-git-send-email-ldewangan@nvidia.com>
 <1466000018-16784-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <57627613.2000409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2016 04:13 PM, Laxman Dewangan wrote:
> Maxim has used the same clock IP on multiple PMICs like
> MAX77686, MAX77802, MAX77620. Only differences are the
> number of clocks from these PMICs.
> 
> Add clock binding details and example for the max77620 in
> maxim,max77686.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> CC: Javier Martinez Canillas <javier@dowhile0.org>
> ---
>  .../devicetree/bindings/clock/maxim,max77686.txt   | 38 +++++++++++++++++++---
>  include/dt-bindings/mfd/max77620.h                 |  4 +++
>  2 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/maxim,max77686.txt b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
> index 354e5ab..24deb19 100644
> --- a/Documentation/devicetree/bindings/clock/maxim,max77686.txt
> +++ b/Documentation/devicetree/bindings/clock/maxim,max77686.txt
> @@ -1,8 +1,11 @@
> -Binding for Maxim MAX77686/MAX77802 32k clock generator block
> +Binding for Maxim MAX77686/MAX77802/MAX77620 32k clock generator block
>  
> -This is a part of device tree bindings of MAX77686/MAX77802 multi-function
> -device. More information can be found in bindings/mfd/max77686.txt file for
> -MAX77686 and bindings/mfd/max77802.txt for MAX77802.
> +This is a part of device tree bindings of MAX77686/MAX77802/MAX77620
> +multi-function device. More information can be found in MFD DT binding
> +doc as follows:
> +	bindings/mfd/max77686.txt for MAX77686 and
> +	bindings/mfd/max77802.txt for MAX77802 and
> +	bindings/mfd/max77620.txt for MAX77620.
>  
>  The MAX77686 contains three 32.768khz clock outputs that can be controlled
>  (gated/ungated) over I2C.
> @@ -10,6 +13,9 @@ The MAX77686 contains three 32.768khz clock outputs that can be controlled
>  The MAX77802 contains two 32.768khz clock outputs that can be controlled
>  (gated/ungated) over I2C.
>  
> +The MAX77686 contains one 32.768khz clock outputs that can be controlled
> +(gated/ungated) over I2C.
> +
>  Following properties should be presend in main device node of the MFD chip.

Please update the information about allowed IDs.

>  
>  Required properties:
> @@ -82,3 +88,27 @@ Example:
>  			clock-names = "my-clock";
>  			clocks = <&max77802 MAX77802_CLK_32K_AP>;
>  		};
> +
> +
> +3. With MAX77620:
> +
> +#include <dt-bindings/mfd/max77620.h>
> +:::

Same as before: ':::'

> +
> +	Node of the MFD chip
> +		max77620: max77620 at 3c {
> +			compatible = "maxim,max77620";
> +			reg = <0x3c>;
> +			:::
> +			#clock-cells = <1>;
> +			:::
> +		};
> +
> +	Clock consumer node
> +
> +		foo at 0 {
> +			compatible = "bar,foo";
> +			/* ... */
> +			clock-names = "my-clock";
> +			clocks = <&max77620 MAX77620_CLK_32K_OUT0>;
> +		};
> diff --git a/include/dt-bindings/mfd/max77620.h b/include/dt-bindings/mfd/max77620.h
> index b911a07..e1bd08c 100644
> --- a/include/dt-bindings/mfd/max77620.h
> +++ b/include/dt-bindings/mfd/max77620.h
> @@ -36,4 +36,8 @@
>  #define MAX77620_FPS_SRC_NONE			3
>  #define MAX77620_FPS_SRC_DEF			4
>  
> +/* MAX77686 clocks */

copy&paste error.

> +#define MAX77620_CLKS_NUM			1
> +#define MAX77620_CLK_32K_OUT0			0

First clk ID, then NUM.

Best regards,
Krzysztof


> +
>  #endif
> 
