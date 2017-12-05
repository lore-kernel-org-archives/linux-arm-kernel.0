From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 10:07:06 +0100
Subject: [PATCH] ARM: dts: sun8i: h3: enable USB OTG for NanoPi Neo board
In-Reply-To: <20171201224942.GA12473@t440.localdomain>
References: <20171201224942.GA12473@t440.localdomain>
Message-ID: <20171205090706.et5a7dizkhn6auje@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 01, 2017 at 11:49:42PM +0100, Krzysztof Adamski wrote:
> Similarly to Orange Pi Zero, NanoPi Neo board has an USB OTG port with
> an ID pin but with unpowered VBUS. This patch enables this port in
> forced peripheral mode.
> 
> Signed-off-by: Krzysztof Adamski <k@japko.eu>
> ---
> arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
> index 78f6c24952dd..14c3f137dbd3 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
> @@ -53,3 +53,20 @@
> 	allwinner,leds-active-low;
> 	status = "okay";
> };
> +
> +&usb_otg {
> +	status = "okay";
> +	dr_mode = "peripheral";
> +};
> +
> +&usbphy {
> +	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};

Please sort the nodes in alphabetical order.

Also, does it make sense to add the OHCI and EHCI controller for a
peripheral-only device?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/65c82fac/attachment.sig>
