From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 14 Jan 2016 13:45:02 +0100
Subject: [PATCH 1/2] ARM: dts: rockchip: increase vdd_arm voltage for
 rk3066a-rayeager board
In-Reply-To: <1452774860-16572-1-git-send-email-andy.yan@rock-chips.com>
References: <1452774780-16493-1-git-send-email-andy.yan@rock-chips.com>
 <1452774860-16572-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1709463.R522kSjgXB@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Donnerstag, 14. Januar 2016, 20:34:20 schrieb Andy Yan:
> The current vdd_arm voltage is too low, increase it will make
> the system more stable.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk3066a-rayeager.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts
> b/arch/arm/boot/dts/rk3066a-rayeager.dts index 0bf6876..3d4c104 100644
> --- a/arch/arm/boot/dts/rk3066a-rayeager.dts
> +++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
> @@ -159,6 +159,14 @@
> 
>  &cpu0 {
>  	cpu0-supply = <&vdd_arm>;
> +	operating-points = <
> +		/* kHz    uV */
> +		1008000 1125000
> +		816000  1125000
> +		600000  1100000
> +		504000  1100000
> +		312000  1075000
> +	>;
>  };
> 
>  &emac {

Does this only apply to the rayeager-board / px2 soc or for all rk3066a/px2 
boards? I.e. the original values come from some sdk kernel and I might've 
transcribed that wrong at the time and I remember having problems trying to 
reach higher frequencies as well.

So could you check what the full operating points looks like for both and if 
this can move to the rk3066a.dtsi, as both should be able to reach at least 
1.4GHz / 1.6GHz.


Thanks
Heiko
