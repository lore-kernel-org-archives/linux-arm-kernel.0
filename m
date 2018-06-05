From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Tue, 05 Jun 2018 15:06:56 +0200
Subject: [PATCH V2] ARM: dts: armada388-helios4
In-Reply-To: <20180605124738.24844-1-dennis@ausil.us> (Dennis Gilmore's
 message of "Tue, 5 Jun 2018 07:47:38 -0500")
References: <20180605124738.24844-1-dennis@ausil.us>
Message-ID: <87muw9tma7.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dennis,
 
 On mar., juin 05 2018, Dennis Gilmore <dennis@ausil.us> wrote:

> The helios4 is a Armada388 based nas board designed by SolidRun and
> based on their SOM. It is sold by kobol.io the dts file came from
> https://raw.githubusercontent.com/armbian/build/master/patch/kernel/mvebu-default/95-helios4-device-tree.patch
> I added a SPDX license line to match the clearfog it says it was based
> on and a compatible line for "kobol,helios4"

This patch looks good, I have only two remarks for now.

> +	usb3_phy: usb3-phy {
> +		compatible = "usb-nop-xceiv";
> +		//vbus-regulator = <&reg_5p0v_usb>;
Why did you comment this line?
What about removing it, if you don't need it?

[...]
> +
> +			usb at 58000 {
> +				//vcc-supply = <&reg_5p0v_usb>;
Same here

> +				usb-phy = <&usb2_phy>;
> +				status = "okay";
> +			};
> +

Gregory

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
