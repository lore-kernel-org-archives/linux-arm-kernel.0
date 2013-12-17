From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 09:36:09 +0800
Subject: [PATCH 1/4] ARM: imx: update i.MX6Q dts setting of VDDARM_CAP
 voltage
In-Reply-To: <1387228057-349-1-git-send-email-b20788@freescale.com>
References: <1387228057-349-1-git-send-email-b20788@freescale.com>
Message-ID: <20131217013607.GA6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 04:07:37PM -0500, Anson Huang wrote:
> According to datasheet, VDD_CACHE_CAP must not exceed VDDARM_CAP
> by more than 200mV, as all of i.MX6Q boards' VDD_CACHE_CAP currently
> are connected to VDDSOC_CAP, so we need to follow this rule by
> increasing VDDARM_CAP's voltage.

The commit log is a little bit vague, and you should probably make the
following points clearer.

1. This is only a problem for 396MHz operating-point, and the other 3
   are fine.

2. What's the VDDSOC_CAP value for 396MHz operating-point right now?
   From what I read drivers/cpufreq/imx6q-cpufreq.c, it's 1250mV.  Then
   the obvious question is why we're not increasing VDDARM_CAP to
   1250 - 200 = 1050mV but 975mV?

Shawn

> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 101c434..e7e8332 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -28,7 +28,7 @@
>  				1200000 1275000
>  				996000  1250000
>  				792000  1150000
> -				396000  950000
> +				396000  975000
>  			>;
>  			clock-latency = <61036>; /* two CLK32 periods */
>  			clocks = <&clks 104>, <&clks 6>, <&clks 16>,
> -- 
> 1.7.9.5
> 
> 
