From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 03 Apr 2013 11:27:02 +0200
Subject: [PATCH 2/4] ARM: kirkwood: add device node entries for the gigabit
 interfaces
In-Reply-To: <1364580879-4297-3-git-send-email-florian@openwrt.org>
References: <1364580879-4297-1-git-send-email-florian@openwrt.org>
 <1364580879-4297-3-git-send-email-florian@openwrt.org>
Message-ID: <515BF5E6.5040703@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/29/13 19:14, Florian Fainelli a ?crit :
> This patch modifies kirkwood.dtsi to specify the various gigabit
> interfaces nodes available on kirkwood devices. They are disabled by
> default and should be enabled on a per-board basis. egiga0 and egiga1
> aliases are defined for convenience. The mdio node is also present and
> should be enabled on a per-board basis as well.
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---

[snip]

> +
> +		ethernet-group at 70000 {

This one is off-by 0x2000 and should have been 72000

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "marvell,mv643xx-eth-block";
> +			reg = <0x70000 0x4000>;

Same here

> +			tx-csum-limit = <1600>;
> +			status = "disabled";
> +
> +			egiga0: egiga0 at 0 {
> +				device_type = "network";
> +				compatible = "marvell,mv643xx-eth";
> +				reg = <0>;
> +				interrupts = <11>;
> +				clocks = <&gate_clk 0>;
> +				clock-names = "0";
> +			};
> +		};
> +
> +		ethernet-group at 74000 {

And here, it should be 76000

> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "marvell,mv643xx-eth-block";
> +			reg = <0x74000 0x4000>;

And here too.
--
Florian
