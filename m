From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 25 Jun 2016 09:18:09 +0200
Subject: [PATCH v2 13/14] ARM: dts: sun8i: Add gpio-regulator used on
 Orange Pi One
In-Reply-To: <20160625034511.7966-14-megous@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-14-megous@megous.com>
Message-ID: <20160625071808.GE4000@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 05:45:10AM +0200, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Xulong Orange Pi One uses GPIO based regulator that
> switches between two voltages: 1.1V and 1.3V. The
> regulator is controlled from the PL6 pin.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
> v2
> - add missing pinctrl-names for gpio-regulator
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> index 0adf932..b1bd6b0 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
> @@ -88,6 +88,25 @@
>  			gpios = <&r_pio 0 3 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	vdd_soc: gpio-regulator {
> +		compatible = "regulator-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_reg_r_opc>;
> +
> +		regulator-name = "soc-vdd-supply";
> +		regulator-min-microvolt = <1100000>;
> +		regulator-max-microvolt = <1300000>;
> +		regulator-boot-on;
> +		regulator-type = "voltage";

It should be marked as always-on.

Otherwise, if the cpufreq driver is not enabled, the regulator will be
shutdown, which is not that great :)

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160625/afaa2985/attachment.sig>
