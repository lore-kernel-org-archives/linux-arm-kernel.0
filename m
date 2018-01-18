From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 18 Jan 2018 17:40:29 +0530
Subject: [PATCH v5 20/44] dt-bindings: clock: Add bindings for TI DA8XX
 USB PHY clocks
In-Reply-To: <1515377863-20358-21-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-21-git-send-email-david@lechnology.com>
Message-ID: <33f0feba-adee-e365-54d5-16fe3d49302d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 07:47 AM, David Lechner wrote:
> This adds a new binding for TI DA8XX USB PHY clocks. These clocks are part
> of a syscon register called CFGCHIP3.

CFGCHIP2

> 
> Signed-off-by: David Lechner <david@lechnology.com>

> +Examples:
> +
> +	cfgchip: syscon at 1417c {
> +		compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
> +		reg = <0x1417c 0x14>;
> +
> +		usb0_phy_clk: usb0-phy-clock {
> +			compatible = "ti,da830-usb0-phy-clock";
> +			#clock-cells = <0>;
> +			clocks = <&usb_refclkin>, <&pll0_aux_clk>, <&psc1 1>;
> +			clock-names = "usb_refclkin", "auxclk", "usb0_lpsc";
> +			clock-output-names = "usb0_phy_clk";

Probably call this "usb0_phy" to match with the input name used for
usb1_phy_clk?

> +		};
> +
> +		usb1_phy_clk: usb1-phy-clock {
> +			compatible = "ti,da830-usb1-phy-clock";
> +			#clock-cells = <0>;
> +			clocks = <&usb0_phy_clk>, <&usb_refclkin>;
> +			clock-names = "usb0_phy", "usb_refclkin";
> +			clock-output-names = "usb1_phy_clk";
> +		};
> +	};

Thanks,
Sekhar
