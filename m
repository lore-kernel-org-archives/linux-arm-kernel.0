From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 11:42:33 +0200
Subject: [PATCH 08/29] ARM: orion5x: move interrupt controller node into
 ocp
In-Reply-To: <1397400006-4315-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BAD89.5090302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> The interrupt controller node was located outside of the ocp at f1000000
> node, which doesn't make much sense: like any other device, the
> interrupt controller has registers located in the "Internal Registers
> Window", so it is much more logical to have it under the ocp at f1000000
> node.
>
> It is even more important as we are going to move Orion5x to use the
> Device Tree binding of the mvebu-mbus driver.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/orion5x.dtsi | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
> index 174d892..da57fb9 100644
> --- a/arch/arm/boot/dts/orion5x.dtsi
> +++ b/arch/arm/boot/dts/orion5x.dtsi
> @@ -17,13 +17,6 @@
>   		gpio0 = &gpio0;
>   	};
>
> -	intc: interrupt-controller {
> -		compatible = "marvell,orion-intc";
> -		interrupt-controller;
> -		#interrupt-cells = <1>;
> -		reg = <0xf1020200 0x08>;
> -	};
> -
>   	ocp at f1000000 {
>   		compatible = "simple-bus";
>   		ranges = <0x00000000 0xf1000000 0x4000000
> @@ -79,6 +72,13 @@
>   			status = "disabled";
>   		};
>
> +		intc: interrupt-controller at 20200 {
> +			compatible = "marvell,orion-intc";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			reg = <0x20200 0x08>;
> +		};
> +
>   		wdt at 20300 {
>   			compatible = "marvell,orion-wdt";
>   			reg = <0x20300 0x28>;
>
