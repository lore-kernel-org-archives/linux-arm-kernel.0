From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 19 Sep 2016 11:25:22 +0200
Subject: [PATCH] arm: dts: fix rk3066a based boards vdd_log voltage
 initialization
In-Reply-To: <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
References: <1474274639-27768-1-git-send-email-andy.yan@rock-chips.com>
 <1474274696-28090-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <20160919112522.5567b882@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Sep 2016 16:44:56 +0800
Andy Yan <andy.yan@rock-chips.com> wrote:

> The current rk3066a based boards(Rayeager, Bqcurie2, Marsboard) use
> pwm modulate vdd_logic voltage, but the pwm is default disabled and
> the pwm pin acts as a gpio before pwm regulator probed, so the pwm
> regulator driver will get a zero dutycycle at probe time, so change
> the initial dutycycle to zero to match pwm_regulator_init_state check.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 2 +-
>  arch/arm/boot/dts/rk3066a-marsboard.dts | 2 +-
>  arch/arm/boot/dts/rk3066a-rayeager.dts  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> index bc674ee..618450d 100644
> --- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> +++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
> @@ -61,7 +61,7 @@
>  		regulator-min-microvolt = <1200000>;
>  		regulator-max-microvolt = <1200000>;
>  		regulator-always-on;
> -		voltage-table = <1000000 100>,
> +		voltage-table = <1000000 0>,
>  				<1200000 42>;

So, it seems you are reversing the PWM polarity here. Are you sure you
shouldn't change the 2nd entry of this table (<1200000 58>)?

>  		status = "okay";
>  	};
> diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
> index a2b763e..ddc680b 100644
> --- a/arch/arm/boot/dts/rk3066a-marsboard.dts
> +++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
> @@ -59,7 +59,7 @@
>  		regulator-min-microvolt = <1200000>;
>  		regulator-max-microvolt = <1200000>;
>  		regulator-always-on;
> -		voltage-table = <1000000 100>,
> +		voltage-table = <1000000 0>,
>  				<1200000 42>;
>  		status = "okay";
>  	};
> diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
> index 2536b3a..30aee99 100644
> --- a/arch/arm/boot/dts/rk3066a-rayeager.dts
> +++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
> @@ -84,7 +84,7 @@
>  		regulator-min-microvolt = <1200000>;
>  		regulator-max-microvolt = <1200000>;
>  		regulator-always-on;
> -		voltage-table = <1000000 100>,
> +		voltage-table = <1000000 0>,
>  				<1200000 42>;
>  		status = "okay";
>  	};
