From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Jul 2013 16:19:02 +0100
Subject: [PATCH V2 7/8] ARM: dts: wm8994: Add wm8994 support on smdk5420
In-Reply-To: <1374845812-7803-8-git-send-email-padma.v@samsung.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-8-git-send-email-padma.v@samsung.com>
Message-ID: <20130726151902.GL9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 07:06:51PM +0530, Padmavathi Venna wrote:
> This patch adds wm8994 codec node on i2c bus1 and the required
> regulator supplies and properties on smdk5420 board.

This isn't a device tree patch for WM8994, it's a patch for the
SMDK5420.

> +	vdd: fixed-regulator at 0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vdd-supply";

These names look wrong - they should reflect the names in the schematic
as they're for human comprehensibility.  This may just be a case of
dropping the -supply.

> +		wm8994: wm8994 at 1a {
> +			compatible = "wlf,wm8994";
> +			reg = <0x1a>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			AVDD2-supply = <&vdd>;
> +			CPVDD-supply = <&vdd>;
> +			DBVDD-supply = <&dbvdd>;
> +			SPKVDD1-supply = <&spkvdd>;
> +			SPKVDD2-supply = <&spkvdd>;
> +		};

It would be helpful to also add a clock binding (I posted a binding
documentation update the other day, it's in my tree now) but it's not
essential and I suspect it needs some work on the clock driver side
still.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/ae020c5c/attachment-0001.sig>
