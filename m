From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Jul 2015 12:11:08 +0200
Subject: [PATCH 2/5] ARM: dts: sun5i: Enable USB DRC on A10s OLinuxIno
 Micro
In-Reply-To: <1438333194-21181-3-git-send-email-hdegoede@redhat.com>
References: <1438333194-21181-1-git-send-email-hdegoede@redhat.com>
 <1438333194-21181-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150731101108.GC2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:59:51AM +0200, Hans de Goede wrote:
> Enable the otg/drc usb controller on the A10s OLinuxIno Micro.
> 
> Note the A10s OlinuxIno Micro always has some voltage on its otg power
> pin, even if the usb-vbus0-regulator is disabled, the leaked voltage is
> enough to make vbus-det always report 1, so we do not use vbus-det on
> this board.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 30 +++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> index 7b26e17..5eebd21 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> @@ -196,6 +196,10 @@
>  	status = "okay";
>  };
>  
> +&otg_sram {
> +	status = "okay";
> +};
> +
>  &pio {
>  	mmc0_cd_pin_olinuxino_micro: mmc0_cd_pin at 0 {
>  		allwinner,pins = "PG1";
> @@ -224,6 +228,22 @@
>  		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>  		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>  	};
> +
> +	usb0_vbus_pin_a: usb0_vbus_pin at 0 {
> +		allwinner,pins = "PG11";
> +	};

We usually have this as a reference, instead of doing it through the
full path.

It makes it clearer that we override something, and we don't define a
new node.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/e3a5ee3e/attachment-0001.sig>
