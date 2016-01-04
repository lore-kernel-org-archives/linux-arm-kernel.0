From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 04 Jan 2016 10:10:29 +0100
Subject: [PATCH v2] ARM: dts: rockchip: Adding LEDs handling via
 leds-gpio for the Radxa Rock2 Square
In-Reply-To: <1451553232-2533-1-git-send-email-romain.perier@gmail.com>
References: <1451553232-2533-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1451898629.3269.11.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-12-31 at 10:13 +0100, Romain Perier wrote:
> Describe the two user-controllable LEDs on Rock2 Square boards.
> All information have been retrieved from the schematics and the
> vendor
> devicetree. The default-triggers mimic the behaviour of the vendor-
> kernel to
> keep functionalities in sync.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

Reviewed-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

> ---
> 
> Changes in v2:
> - Changed labels according to what is defined in the schematics
> - Added a long commit message describing this patch in details
> 
> ?arch/arm/boot/dts/rk3288-rock2-square.dts | 17 +++++++++++++++++
> ?1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
> b/arch/arm/boot/dts/rk3288-rock2-square.dts
> index c5453a0..0813428 100644
> --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
> +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
> @@ -56,6 +56,23 @@
> ?		pinctrl-0 = <&ir_int>;
> ?	};
> ?
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		heartbeat {
> +			gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
> +			label = "rock2:green:state1";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		mmc {
> +			gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
> +			label = "rock2:blue:state2";
> +			linux,default-trigger = "mmc0";
> +		};
> +	};
> +
> +
> ?	sound {
> ?		compatible = "simple-audio-card";
> ?		simple-audio-card,name = "SPDIF";

-- 
Sjoerd Simons
Collabora Ltd.
