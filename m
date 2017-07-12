From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 13 Jul 2017 01:56:45 +0200
Subject: [PATCH v2 2/6] ARM: dts: rockchip: add cpu-supply property for
 cpu node of rk3229-evb
In-Reply-To: <1499243421-21460-3-git-send-email-frank.wang@rock-chips.com>
References: <1499243421-21460-1-git-send-email-frank.wang@rock-chips.com>
 <1499243421-21460-3-git-send-email-frank.wang@rock-chips.com>
Message-ID: <1800759.4Nsb10uDMe@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. Juli 2017, 16:30:17 CEST schrieb Frank Wang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch adds the cpu-supply property so that cpu can do dvfs
> on rk3229-evb board.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3229-evb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3229-evb.dts b/arch/arm/boot/dts/rk3229-evb.dts
> index 394be63..17385d8 100644
> --- a/arch/arm/boot/dts/rk3229-evb.dts
> +++ b/arch/arm/boot/dts/rk3229-evb.dts
> @@ -141,6 +141,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&vdd_arm>;
> +};
> +

applied for 4.14 after adding the same for cpu1-cpu3 .

The supply is a property of the cpu-core, so each should have the reference
even though the Linux cpufreq driver taking the regulator from cpu0.


Heiko
