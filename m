From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Aug 2015 16:50:57 +0200
Subject: [PATCH 2/6] ARM: dts: sun7i: Enable i2c bus 1 and 2 on the Wits
 A20 Pro DKT
In-Reply-To: <1439563477-12295-3-git-send-email-hdegoede@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
 <1439563477-12295-3-git-send-email-hdegoede@redhat.com>
Message-ID: <55CE0051.4010403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 14-08-15 16:44, Hans de Goede wrote:
> Enable i2c bus 1 and 2 on the Wits A20 Pro DKT, these are used for
> the touchscreen resp. the accelerometer.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Erm, please skip this one it depends on another patch
(which adds the sun7i-a20-wits-pro-a20-dkt.dts), which
I've not submitted yet as it depends on the axp
usb-power-supply driver.

So as said please skip this one, I've squashed it into
the patch adding the dts file, which I will submit
later.

Regards,

Hans



> ---
>   arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
> index da47608..85b500d 100644
> --- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
> @@ -92,6 +92,18 @@
>   	};
>   };
>
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins_a>;
> +	status = "okay";
> +};
> +
>   #include "axp209.dtsi"
>
>   &mmc0 {
>
