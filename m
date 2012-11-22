From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 22 Nov 2012 22:11:47 +0100
Subject: [PATCH v4 10/11] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evm
In-Reply-To: <1353503469-18634-11-git-send-email-avinashphilip@ti.com>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-11-git-send-email-avinashphilip@ti.com>
Message-ID: <20121122211147.GI16716@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 06:41:07PM +0530, Philip, Avinash wrote:
[...]
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 9f65f17..4178ba4 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -44,6 +44,12 @@
>  				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
>  			>;
>  		};
> +
> +		ecap0_pins: backlight_pins {
> +			pinctrl-single,pins = <
> +				0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
> +			>;

This looks kind of funky, but I see the rest of the file uses similar
formatting, so I guess it's okay.

> @@ -158,6 +174,13 @@
>  			gpio-key,wakeup;
>  		};
>  	};
> +
> +	backlight {
> +		compatible	= "pwm-backlight";

Maybe you don't want a tab between "compatible" and "=", but a space
instead.

Other than that, looks good:

Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/00b2e7b5/attachment.sig>
