From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:24:01 +0200
Subject: [PATCH v2 21/38] ARM: orion5x: convert to use 'clocks' property
 for UART controllers
In-Reply-To: <1398202002-28530-22-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-22-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A2D1.70706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> Until the previous commit, the Orion5x clocks were not described in
> the Device Tree. Now that they are described in the Device Tree, we
> can replace the manual 'clock-frequency' property in the UART nodes
> by a nicer 'clocks' reference in those UART nodes.
>
> This commit consequently removes the 'clock-frequency' property from
> the LaCie edmini_v2 board, which is at this point the only Orion5x
> board converted to the Device Tree.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 1 -
>   arch/arm/boot/dts/orion5x.dtsi                            | 4 ++--
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index 83f45a7..ba43197 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -73,6 +73,5 @@
>   };
>
>   &uart0 {
> -	clock-frequency = <166666667>;
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
> index ad23ff4..88df8a8 100644
> --- a/arch/arm/boot/dts/orion5x.dtsi
> +++ b/arch/arm/boot/dts/orion5x.dtsi
> @@ -65,7 +65,7 @@
>   				reg = <0x12000 0x100>;
>   				reg-shift = <2>;
>   				interrupts = <3>;
> -				/* set clock-frequency in board dts */
> +				clocks = <&core_clk 0>;
>   				status = "disabled";
>   			};
>
> @@ -74,7 +74,7 @@
>   				reg = <0x12100 0x100>;
>   				reg-shift = <2>;
>   				interrupts = <4>;
> -				/* set clock-frequency in board dts */
> +				clocks = <&core_clk 0>;
>   				status = "disabled";
>   			};
>
>
