From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 12:11:51 +0100
Subject: [PATCH] ARM: dts: remove blank interrupt-parent properties
In-Reply-To: <1334243848-29522-1-git-send-email-robherring2@gmail.com>
References: <1334243848-29522-1-git-send-email-robherring2@gmail.com>
Message-ID: <4F8809F7.703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/12 16:17, Rob Herring wrote:
> From: Rob Herring<rob.herring@calxeda.com>
>
> These were incorrectly introduced and can cause problems for of_irq_init.
>
> The correct way to define a root controller is no interrupt-parent set at
> all or the interrupt-parent is set to the root controller itself when
> inherited from a parent node.
>
> Signed-off-by: Rob Herring<rob.herring@calxeda.com>

Tested-by: Lee Jones <lee.jones@linaro.org>

Works for me. Now I can use my GPIO chained IRQs correctly.

> ---
> Arnd, Olof,
>
> Please apply for 3.4.
>
> Rob
>
>   arch/arm/boot/dts/at91sam9g20.dtsi |    1 -
>   arch/arm/boot/dts/at91sam9g45.dtsi |    1 -
>   arch/arm/boot/dts/at91sam9x5.dtsi  |    1 -
>   arch/arm/boot/dts/db8500.dtsi      |    1 -
>   arch/arm/boot/dts/highbank.dts     |    1 -
>   5 files changed, 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index 92f3662..6c33256 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -55,7 +55,6 @@
>   				#interrupt-cells =<2>;
>   				compatible = "atmel,at91rm9200-aic";
>   				interrupt-controller;
> -				interrupt-parent;
>   				reg =<0xfffff000 0x200>;
>   			};
>
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 3d0c32f..2815be1 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -56,7 +56,6 @@
>   				#interrupt-cells =<2>;
>   				compatible = "atmel,at91rm9200-aic";
>   				interrupt-controller;
> -				interrupt-parent;
>   				reg =<0xfffff000 0x200>;
>   			};
>
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index c111001..1995c44 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -54,7 +54,6 @@
>   				#interrupt-cells =<2>;
>   				compatible = "atmel,at91rm9200-aic";
>   				interrupt-controller;
> -				interrupt-parent;
>   				reg =<0xfffff000 0x200>;
>   			};
>
> diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
> index d73dce6..14bc307 100644
> --- a/arch/arm/boot/dts/db8500.dtsi
> +++ b/arch/arm/boot/dts/db8500.dtsi
> @@ -24,7 +24,6 @@
>   			#interrupt-cells =<3>;
>   			#address-cells =<1>;
>   			interrupt-controller;
> -			interrupt-parent;
>   			reg =<0xa0411000 0x1000>,
>   			<0xa0410100 0x100>;
>   		};
> diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
> index 357e780..4121b06 100644
> --- a/arch/arm/boot/dts/highbank.dts
> +++ b/arch/arm/boot/dts/highbank.dts
> @@ -100,7 +100,6 @@
>   			#size-cells =<0>;
>   			#address-cells =<1>;
>   			interrupt-controller;
> -			interrupt-parent;
>   			reg =<0xfff11000 0x1000>,
>   			<0xfff10100 0x100>;
>   		};


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
