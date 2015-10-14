From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2015 12:23:35 -0700
Subject: [PATCH] Add USB hooks into NanoBone DTS file
In-Reply-To: <561E5908.8010004@newflow.co.uk>
References: <561E5908.8010004@newflow.co.uk>
Message-ID: <20151014192335.GG10113@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Jackson <mpfj@newflow.co.uk> [151014 06:35]:
> Add USB hooks into NanoBone DTS file

Hmm looking at things, we really should not set status = "disabled"
for any of the internal devices. Setting "disabled" makes the kernel
completely ignore the device and we're better off from PM point of
view to probe and idle the device. The devices are there for sure, and
typically just the pins are not configured for them.

How about just remove the status = "disabled" from am33xx.dtsi
instead?

Regards,

Tony

> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> ---
>  arch/arm/boot/dts/am335x-nano.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
> index 5ed4ca6..b86937a 100644
> --- a/arch/arm/boot/dts/am335x-nano.dts
> +++ b/arch/arm/boot/dts/am335x-nano.dts
> @@ -375,6 +375,23 @@
>  	wp-gpios = <&gpio3 18 0>;
>  };
>  
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb_ctrl_mod {
> +	status = "okay";
> +};
> +
> +&usb0_phy {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
>  #include "tps65217.dtsi"
>  
>  &tps {
> -- 
> 1.9.1
> 
