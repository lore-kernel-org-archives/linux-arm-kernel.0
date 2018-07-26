From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Thu, 26 Jul 2018 16:39:56 +0300
Subject: [PATCH v2 16/18] arm64: dts: allwinner: a64: NanoPi-A64: Add
 Ethernet
In-Reply-To: <20180726003532.18751-17-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
 <20180726003532.18751-17-andre.przywara@arm.com>
Message-ID: <f2380842-2c7a-13d3-fa0f-ed23afb89e30@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/26/2018 03:35 AM, Andre Przywara wrote:
> The NanoPi-A64 has the usual Realtek Gbit PHY connected to the EMAC,
> so add the respective nodes to the DT. The PHY is powered by the
> VDD_SYS_3.3V line, which is always on.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>   arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> index 5caba225b4f7..bd35a093e6cd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> @@ -51,6 +51,7 @@
>   	compatible = "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";
>   
>   	aliases {
> +		ethernet0 = &emac;
>   		serial0 = &uart0;
>   	};
>   
> @@ -67,6 +68,15 @@
>   	status = "okay";
>   };
>   
> +&emac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&ext_rgmii_phy>;
> +	phy-supply = <&reg_dcdc1>;
> +	status = "okay";
> +};
> +
>   /* i2c1 connected with gpio headers like pine64, bananapi */
>   &i2c1 {
>   	pinctrl-names = "default";
> @@ -78,6 +88,13 @@
>   	bias-pull-up;
>   };
>   
> +&mdio {
> +	ext_rgmii_phy: ethernet-phy at 1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <1>;
> +	};
> +};
> +
>   &mmc0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&mmc0_pins>;

did you test? "reg = <1>" on a real hardware ?

I have? "reg = <0>" in my dts? and? it has been working on my board for 
ages.

Thanks
