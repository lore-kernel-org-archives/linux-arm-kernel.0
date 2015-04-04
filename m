From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 4 Apr 2015 14:44:58 +0200
Subject: [PATCH v2] ARM: dts: sun5i: Enable touchscreen on Utoo P66
In-Reply-To: <1427902177-26526-1-git-send-email-hdegoede@redhat.com>
References: <1427902177-26526-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150404124458.GI14618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Wed, Apr 01, 2015 at 05:29:37PM +0200, Hans de Goede wrote:
> Add a node for the chipone-icn8318 touchscreen found on the Utoo P66 tablet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Fix touchscreen node name
> ---
>  arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> index 9108ecd..00bdf28 100644
> --- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> @@ -50,6 +50,7 @@
>  #include "sunxi-common-regulators.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
>  
>  / {
> @@ -93,6 +94,20 @@
>  	pinctrl-0 = <&i2c1_pins_a>;
>  	status = "okay";
>  
> +	icn8318: touchscreen at 40 {
> +		compatible = "chipone,icn8318";
> +		reg = <0x40>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */

I don't think you sent a reply to this comment, but this should really
be in a pinctrl node so that no one else can request the pin and
change its muxing and it shows up in debugfs.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150404/9ef6c2c4/attachment.sig>
