From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 13:41:11 +0000
Subject: [PATCH v5 4/5] mfd/regulator: dt-bindings: max77686: Document
 gpio properties
In-Reply-To: <1420458525-22576-5-git-send-email-k.kozlowski@samsung.com>
References: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
 <1420458525-22576-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150120134111.GI13701@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 Jan 2015, Krzysztof Kozlowski wrote:

> Document usage of maxim,ena-gpios properties which turn on external/GPIO
> control over regulator.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/mfd/max77686.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max77686.txt b/Documentation/devicetree/bindings/mfd/max77686.txt
> index 75fdfaf41831..e39f0bc1f55e 100644
> --- a/Documentation/devicetree/bindings/mfd/max77686.txt
> +++ b/Documentation/devicetree/bindings/mfd/max77686.txt
> @@ -39,6 +39,12 @@ to get matched with their hardware counterparts as follow:
>  	-BUCKn	:	1-4.
>    Use standard regulator bindings for it ('regulator-off-in-suspend').
>  
> +  LDO20, LDO21, LDO22, BUCK8 and BUCK9 can be configured to GPIO enable
> +  control. To turn this feature on this property must be added to the regulator
> +  sub-node:
> +	- maxim,ena-gpios :	one GPIO specifier enable control (the gpio
> +				flags are actually ignored and always
> +				ACTIVE_HIGH is used)

How does this differ to the 'enable-gpio' property which has already
been defined?

>  Example:
>  
> @@ -65,4 +71,12 @@ Example:
>  				regulator-always-on;
>  				regulator-boot-on;
>  			};
> +
> +			buck9_reg {
> +				regulator-compatible = "BUCK9";
> +				regulator-name = "CAM_ISP_CORE_1.2V";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1200000>;
> +				maxim,ena-gpios = <&gpm0 3 GPIO_ACTIVE_HIGH>;
> +			};
>  	}

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
