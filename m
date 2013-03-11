From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 10:46:29 -0600
Subject: [PATCH 3/6] arm: dts: vt8500: Update Wondermedia SoC dtsi files
 for pinctrl driver
In-Reply-To: <1362807578-23089-4-git-send-email-linux@prisktech.co.nz>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-4-git-send-email-linux@prisktech.co.nz>
Message-ID: <513E0A65.4000604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2013 10:39 PM, Tony Prisk wrote:
> This patch adds pinctrl nodes to the VIA VT8500 and Wondermedia SoC dtsi
> files to support the pinctrl driver.

> diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi

> +		pinctrl: pinctrl at d8110000 {
> +			compatible = "via,vt8500-pinctrl";
> +			gpio-controller;
> +			reg = <0xd8110000 0x10000>;
> +			#gpio-cells = <2>;
> +			wm,pinmux = <0x00000001 0x00000001>;
> +		};

In the binding documentation, "wm,pinmux" is listed under "optional
sub-node properties", but here the property is included in the main
node, not a sub-node.

I'm a little confused what this property means then...
