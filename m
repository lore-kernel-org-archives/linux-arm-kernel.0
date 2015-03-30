From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Mar 2015 15:52:55 -0700
Subject: [PATCH] ARM: dts: sun5i: Enable touchscreen on Utoo P66
In-Reply-To: <1427652831-12838-2-git-send-email-hdegoede@redhat.com>
References: <1427652831-12838-1-git-send-email-hdegoede@redhat.com>
 <1427652831-12838-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20150330225255.GZ23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sun, Mar 29, 2015 at 08:13:51PM +0200, Hans de Goede wrote:
> Add a node for the chipone-icn8318 touchscreen found on the Utoo P66 tablet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
> index 0f0a411..d1d4d30 100644
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
> +	chipone_icn8318 at 40 {

The node name should be the class of the device, something like
touchscreen at 40 in this case.

> +		compatible = "chipone,icn8318";
> +		reg = <0x40>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>; /* EINT9 (PG9) */

Shouldn't you reference this pin in the pinctrl node too?

If this patch is resent soon enough, I'll merge it and send it through
a late pull request together with the A23 SMP and A31 cpufreq patches.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150330/2466e79c/attachment.sig>
