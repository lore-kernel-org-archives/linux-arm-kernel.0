From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 30 Dec 2016 10:15:01 +0800
Subject: [PATCH] ARM: dts: imx: ventana: add LTC3676 PMIC support
In-Reply-To: <1479325245-1169-1-git-send-email-tharvey@gateworks.com>
References: <1479325245-1169-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20161230021459.GG6177@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 11:40:45AM -0800, Tim Harvey wrote:
> All of the Gateworks Ventana boards based on the IMX6 SoC except for the
> GW54xx use the LTC3676 PMIC. Add a device-tree node with interrupt support
> for this PMIC. Additionally remove the simple-bus notation in the regulator
> nodes and any fixed regulators that are provided by the PMIC.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw51xx.dtsi | 132 ++++++++++++++++++++-------
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 165 ++++++++++++++++++++++++----------
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 163 +++++++++++++++++++++++----------
>  arch/arm/boot/dts/imx6qdl-gw551x.dtsi | 132 +++++++++++++++++++++------
>  arch/arm/boot/dts/imx6qdl-gw552x.dtsi | 130 +++++++++++++++++++++------
>  arch/arm/boot/dts/imx6qdl-gw553x.dtsi |  98 ++++++++++++++++++--
>  6 files changed, 630 insertions(+), 190 deletions(-)

<snip>

> @@ -158,6 +149,81 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_i2c2>;
>  	status = "okay";
> +
> +	pmic: ltc3676 at 3c {

The node name should be generic one, while label should be more
specific.  That said, we should follow the example in ltc3676 bindings
doc to name the node as below.

	ltc3676: pmic at 3c

I fixed all 6 occurrences and applied the patch.

Shawn

> +		compatible = "lltc,ltc3676";
> +		reg = <0x3c>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
