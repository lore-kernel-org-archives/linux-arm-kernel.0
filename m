From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 24 Apr 2017 10:47:22 +0200
Subject: [PATCH v2] arm: imx6: zii: Add i210 PCIe interface to the
 device tree
In-Reply-To: <1492321507-7174-1-git-send-email-cphealy@gmail.com>
References: <1492321507-7174-1-git-send-email-cphealy@gmail.com>
Message-ID: <1493023642.2891.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 15.04.2017, 22:45 -0700 schrieb Chris Healy:
> The board has an Intel i210 Ethernet controller on its PCIe bus. Add a
> device tree node for this.

I wold prefer a better description on why we need this node, as PCIe is
an enumerable bus. Do you need this node to attach a MAC address or
something?

> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> ---
> 
> This patch is against for-next of Shawn Guo's tree.
> 
> Since v1, this version fixes the spacing by using git send-email instead of gmail
> to send the patch.
> 
> Thanks,
> 
> Chris Healy
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 5d94b5e..8375c43 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -572,6 +572,18 @@
>  	pinctrl-0 = <&pinctrl_pcie>;
>  	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> +
> +	host at 0 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		reg = <0 0 0 0 0>;
> +		device_type = "pci";
> +
> +		i210: i210 at 0 {
> +			reg = <0 0 0 0 0>;
> +			device_type = "pci";

device_type = "pci" is only valid for bridges on the bus, not for
endpoint devices. Please remove.

> +		};
> +       };
>  };
>  
>  &usdhc2 {

Regards,
Lucas
