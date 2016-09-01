From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 1 Sep 2016 12:22:51 +0100
Subject: [PATCH v9 3/4] doc: bindings: mfd: act8945a: Update the example
In-Reply-To: <1472722201-31872-4-git-send-email-wenyou.yang@atmel.com>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
 <1472722201-31872-4-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160901112251.GK4921@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 01 Sep 2016, Wenyou Yang wrote:

> Since the act8945a-charger is regarded as a sub-device and it using
> "interrupts" property, update the examples section.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v4: None
> 
>  Documentation/devicetree/bindings/mfd/act8945a.txt | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

This is a functional change.  I'll require a DT Ack.

> diff --git a/Documentation/devicetree/bindings/mfd/act8945a.txt b/Documentation/devicetree/bindings/mfd/act8945a.txt
> index f712830..462819a 100644
> --- a/Documentation/devicetree/bindings/mfd/act8945a.txt
> +++ b/Documentation/devicetree/bindings/mfd/act8945a.txt
> @@ -14,13 +14,6 @@ Example:
>  		reg = <0x5b>;
>  		status = "okay";
>  
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_charger_chglev>;
> -		active-semi,chglev-gpio = <&pioA 12 GPIO_ACTIVE_HIGH>;
> -		active-semi,input-voltage-threshold-microvolt = <6600>;
> -		active-semi,precondition-timeout = <40>;
> -		active-semi,total-timeout = <3>;
> -
>  		active-semi,vsel-high;
>  
>  		regulators {
> @@ -73,4 +66,19 @@ Example:
>  				regulator-always-on;
>  			};
>  		};
> +
> +		charger {
> +			compatible = "active-semi,act8945a-charger";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_charger_chglev &pinctrl_charger_lbo &pinctrl_charger_irq>;
> +			interrupt-parent = <&pioA>;
> +			interrupts = <45 GPIO_ACTIVE_LOW>;
> +
> +			active-semi,chglev-gpios = <&pioA 12 GPIO_ACTIVE_HIGH>;
> +			active-semi,lbo-gpios = <&pioA 72 GPIO_ACTIVE_LOW>;
> +			active-semi,input-voltage-threshold-microvolt = <6600>;
> +			active-semi,precondition-timeout = <40>;
> +			active-semi,total-timeout = <3>;
> +			status = "okay";
> +		};
>  	};

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
