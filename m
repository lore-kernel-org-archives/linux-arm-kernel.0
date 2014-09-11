From: addy.ke@rock-chips.com (Addy)
Date: Thu, 11 Sep 2014 17:17:58 +0800
Subject: [PATCH] ARM: dts: Switch i2c0 to 400kHz on rk3288-evb-rk808
In-Reply-To: <1410409815-22200-1-git-send-email-dianders@chromium.org>
References: <1410409815-22200-1-git-send-email-dianders@chromium.org>
Message-ID: <541168C6.2090603@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11 Sep 2014 12:30, Doug Anderson writes:
> We should be able to talk to the PMIC at 400kHz.  No need to talk at
> the slow 100kHz.
>
> As measured by ftrace (with a bunch of extra patches, since cpufreq
> for rk808 hasn't landed yet):
>   before this change: cpu0_set_target() => ~500us
>   after this change:  cpu0_set_target() => ~300us
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288-evb-rk808.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-evb-rk808.dts b/arch/arm/boot/dts/rk3288-evb-rk808.dts
> index 36db177..ff522f8 100644
> --- a/arch/arm/boot/dts/rk3288-evb-rk808.dts
> +++ b/arch/arm/boot/dts/rk3288-evb-rk808.dts
> @@ -18,6 +18,7 @@
>  };
>  
>  &i2c0 {
> +	clock-frequency = <400000>;
>  	status = "okay";
>  
>  	rk808: pmic at 1b {
I have tested on rk3288-pinky board, it work well. so

Reviewed-by Addy Ke <addy.ke@rock-chips.com>
Tested-by Addy Ke <addy.ke@rock-chips.com>
