From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 01 Mar 2016 20:19:16 +0100
Subject: [PATCH v4 3/5] ARM: dts: omap3-sniper: TWL4030 keypad support
In-Reply-To: <1456663185-14170-4-git-send-email-contact@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
 <1456663185-14170-4-git-send-email-contact@paulk.fr>
Message-ID: <1456859956.1031.39.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le dimanche 28 f?vrier 2016 ? 13:39 +0100, Paul Kocialkowski a ?crit?:
> This adds support for the volume and gesture keys, using TWL4030 keypad.

I noticed this patch hadn't been picked up in:?https://git.kernel.org/cgit/linux
/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v4.6/dt

Should I submit it somewhere else instead?

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
> ?arch/arm/boot/dts/omap3-sniper.dts | 9 +++++++++
> ?1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-sniper.dts b/arch/arm/boot/dts/omap3-
> sniper.dts
> index 6e31daf..78a1184 100644
> --- a/arch/arm/boot/dts/omap3-sniper.dts
> +++ b/arch/arm/boot/dts/omap3-sniper.dts
> @@ -8,6 +8,7 @@
> ?/dts-v1/;
> ?
> ?#include "omap36xx.dtsi"
> +#include <dt-bindings/input/input.h>
> ?
> ?/ {
> ?	model = "LG Optimus Black";
> @@ -226,6 +227,14 @@
> ?#include "twl4030.dtsi"
> ?#include "twl4030_omap3.dtsi"
> ?
> +&twl_keypad {
> +	linux,keymap = <
> +		MATRIX_KEY(0x00, 0x00, KEY_VOLUMEUP)
> +		MATRIX_KEY(0x01, 0x00, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0x02, 0x00, KEY_SELECT)
> +	>;
> +};
> +
> ?/*
> ? * The TWL4030 VAUX2 and VDAC regulators power sensors that are slaves on
> I2C3.
> ? * When not powered, these sensors cause the I2C3 clock to stay low at all
> times,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160301/b4af7293/attachment-0001.sig>
