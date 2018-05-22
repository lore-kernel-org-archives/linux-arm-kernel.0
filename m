From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 22 May 2018 16:30:44 +0200
Subject: [PATCH v3] arm64: allwinner: a64: Add Amarula A64-Relic initial
 support
In-Reply-To: <20180522132228.6564-1-jagan@amarulasolutions.com>
References: <20180522132228.6564-1-jagan@amarulasolutions.com>
Message-ID: <20180522143044.pgwawojiwnk2lzxb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
> Amarula A64-Relic is Allwinner A64 based IoT device, which support
> - Allwinner A64 Cortex-A53
> - Mali-400MP2 GPU
> - AXP803 PMIC
> - 1GB DDR3 RAM
> - 8GB eMMC
> - AP6330 Wifi/BLE
> - MIPI-DSI
> - CSI: OV5640 sensor
> - USB OTG

You claim that this is doing OTG...

[..]

> +&usb_otg {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};

... and yet you're setting it as peripheral...

> +&usbphy {
> +	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
> +	usb0_vbus-supply = <&reg_drivevbus>;

While you have an ID pin and a controllable VBUS. Which one is it?

Maxime
-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180522/f71e03b3/attachment-0001.sig>
