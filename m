From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 18 Dec 2015 22:25:25 +0100
Subject: [PATCH 1/4] ARM: dts: sun7i: Enable touchscreen on Wexler
 TAB7200 tablet
In-Reply-To: <1450428710-5653-1-git-send-email-mamlinav@gmail.com>
References: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
 <1450428710-5653-1-git-send-email-mamlinav@gmail.com>
Message-ID: <20151218212525.GR30359@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 18, 2015 at 11:51:50AM +0300, Aleksei Mamlin wrote:
> Add a node for the Goodix GT911 touchscreen found on the Wexler TAB7200 tablet
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> index 239b5d2..ec3b837 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
> @@ -102,6 +102,18 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c2_pins_a>;
>  	status = "okay";
> +
> +	gt911: touchscreen at 5d {
> +		compatible = "goodix,gt911";
> +		reg = <0x5d>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>; /* EINT21 (PH21) */
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_reset_pin>;
> +		irq-gpios = <&pio 7 21 GPIO_ACTIVE_HIGH>; /* INT (PH21) */

It seems odd that you need both irq-gpios and interrupts. These two
are completely redundant, and you should even actually use only one in
your driver, since the second request_irq will fail.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/18d43e8e/attachment.sig>
