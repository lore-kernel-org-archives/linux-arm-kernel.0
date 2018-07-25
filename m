From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 25 Jul 2018 13:02:44 +0200
Subject: [PATCH 1/3] arm64: dts: rockchip: add WiFi module support for
 Firefly-RK3399
In-Reply-To: <PS2P216MB05327A3B7901DEE585B0BA21D1530@PS2P216MB0532.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB05327A3B7901DEE585B0BA21D1530@PS2P216MB0532.KORP216.PROD.OUTLOOK.COM>
Message-ID: <10441742.bRvTIUQldp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Mittwoch, 18. Juli 2018, 16:58:16 CEST schrieb Maruyama Shohei:
> From: Shohei Maruyama <cheat.sc.linux@outlook.com>
> 
> This commit adds WiFi module support for the Firefly-RK3399.
> 
> Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>

[...]

> +	/* Card detection */
> +	cd-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_LOW>;
> +
> +	/* Write protection */
> +	wp-gpios = <&gpio0 RK_PA3 GPIO_ACTIVE_HIGH>;

these two gpio connections look not correct. According to
the schematics, gpio2_d2 is bt_wake_l and gpio0_a3 is
wifi_host_wake_l, so definitly properties of the wifi module
below and not the sdio controller itself.


> +	brcmf: wifi at 1 {
> +		compatible = "brcm,bcm4329-fmac";
> +		brcm,drive-strength = <5>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA4 GPIO_ACTIVE_HIGH>;

And this seems to be bt_host_wake_l, so not sure
if this is the correct one from the module's point of view.


> +		interrupt-names = "host-wake";
> +	};
> +};


Heiko
