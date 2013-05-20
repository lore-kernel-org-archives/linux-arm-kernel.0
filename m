From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 20 May 2013 23:27:08 +0200
Subject: [PATCH v3 6/7] ARM: kirkwood: add gigabit ethernet and mvmdio
 device tree nodes
In-Reply-To: <1367854420-8006-7-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1367854420-8006-7-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130520212708.GA26519@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Mon, May 06, 2013 at 05:33:39PM +0200, Sebastian Hesselbarth wrote:
> This patch adds mv643xx_eth and mvmdio device tree nodes for DT enabled
> Kirkwood boards. Phy nodes are also added with reg property set on a
> per-board basis.
...
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index fada7e6..c01a273 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -202,5 +202,57 @@
>  			clocks = <&gate_clk 4>;
>  			status = "disabled";
>  		};
> +
> +		mdio: mdio-bus at 72004 {
> +			compatible = "marvell,orion-mdio";
> +			reg = <0x72004 0x84>;
> +			interrupts = <11>;

Shouldn't this be 46?

- Simon
