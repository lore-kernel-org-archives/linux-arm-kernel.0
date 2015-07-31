From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 12:11:57 +0200
Subject: [PATCH 3/5] ARM: dts: sun5i: Enable USB DRC on A13 OLinuxIno
In-Reply-To: <1438333194-21181-4-git-send-email-hdegoede@redhat.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20150731101157.GD2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:59:52AM +0200, Hans de Goede wrote:
> From: Mark Janssen <mark@sig-io.nl>
> 
> Enable the otg/drc usb controller on the A13 OLinuxIno.
> 
> Signed-off-by: Mark Janssen <mark@sig-io.nl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i-a13-olinuxino.dts | 37 +++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
> index 4232400..e659482 100644
> --- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
> @@ -159,6 +159,10 @@
>  	status = "okay";
>  };
>  
> +&otg_sram {
> +	status = "okay";
> +};
> +
>  &pio {
>  	mmc0_cd_pin_olinuxino: mmc0_cd_pin at 0 {
>  		allwinner,pins = "PG0";
> @@ -174,6 +178,24 @@
>  		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  	};
>  
> +	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> +		allwinner,pins = "PG2";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> +	};
> +
> +	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
> +		allwinner,pins = "PG1";
> +		allwinner,function = "gpio_in";
> +		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
> +	};
> +
> +	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
> +		allwinner,pins = "PG12";
> +	};

Same thing here than in patch 2.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/45dfd99e/attachment-0001.sig>
