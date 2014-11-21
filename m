From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 21 Nov 2014 21:18:44 +0100
Subject: [PATCHv5 04/10] arm: mvebu: move Armada 370/XP pinctrl node
 definition armada-370-xp.dtsi
In-Reply-To: <2daf170fc0a35852111a3e101df73c789bbbb276.1416598536.git.arno@natisbad.org>
References: <cover.1416598536.git.arno@natisbad.org>
 <2daf170fc0a35852111a3e101df73c789bbbb276.1416598536.git.arno@natisbad.org>
Message-ID: <20141121201844.GD20238@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud

> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 2be9723bcdf3..8e65abf46fba 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -103,6 +103,10 @@
>  			#size-cells = <1>;
>  			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
>  
> +			pinctrl: pin-ctrl at 18000 {
> +				reg = <0x18000 0x38>;
> +			};
> +
>  			rtc at 10300 {
>  				compatible = "marvell,orion-rtc";
>  				reg = <0x10300 0x20>;

We try to keep entries in these files in numeric address order.
So this should go after serial at 12100

   Andrew
