From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 13 Dec 2016 10:46:44 +0200
Subject: [PATCH v6 4/5] ARM: dts: da850-lcdk: add the vga-bridge node
In-Reply-To: <1481547942-24775-5-git-send-email-bgolaszewski@baylibre.com>
References: <1481547942-24775-1-git-send-email-bgolaszewski@baylibre.com>
 <1481547942-24775-5-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <9d5fa409-bb4f-f62b-2548-0a3b82228e08@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/12/16 15:05, Bartosz Golaszewski wrote:

> +&lcdc {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&lcd_pins>;
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		lcdc_out: port at 1 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;
> +
> +			lcdc_out_vga: endpoint {
> +				reg = <0>;
> +				remote-endpoint = <&vga_bridge_in>;
> +			};
> +		};
> +	};
> +};
> 

This is not correct. LCDC has just one output, so port at 1 doesn't make
sense. It's port at 0. But with just one port, you can leave "ports" away.
And you don't need the port's label for anything, if I'm not mistaken. So:

&lcdc {
	status = "okay";
	pinctrl-names = "default";
	pinctrl-0 = <&lcd_pins>;

	port {
		lcdc_out_vga: endpoint {
			remote-endpoint = <&vga_bridge_in>;
		};
	};
};

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/5ebeac17/attachment.sig>
