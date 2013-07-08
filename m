From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Jul 2013 09:53:50 +0800
Subject: [RFC] ARM: dts: imx27: Add core voltages
In-Reply-To: <1373208662-7350-1-git-send-email-shc_work@mail.ru>
References: <1373208662-7350-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130708015348.GB21594@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 07, 2013 at 06:51:02PM +0400, Alexander Shiyan wrote:
> This patch adds core voltages for i.MX27 CPUs. Only 266 and 400 MHz modes
> is documented in the datasheet, we add a 266 MHz frequency for conform this.
> For 133 MHz CPU frequency minimal voltage is used (1.2V).
> 
Ok, just checked i.MX27 data sheet, it seems that only 266 and 400 MHz
set points are officially supported.  So there is no documented voltage
for 133 MHz.  I'm wondering if we should have 133 MHz set point at all
if it's not officially supported.

Shawn

> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27.dtsi | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index a587294..c9bacca 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -57,13 +57,15 @@
>  			device_type = "cpu";
>  			compatible = "arm,arm926ej-s";
>  			operating-points = <
> -				/* kHz  uV (No regulator support) */
> -				133000  0
> -				399000  0
> +				/* kHz uV */
> +				133000 1200000
> +				266000 1300000
> +				399000 1450000
>  			>;
>  			clock-latency = <61036>; /* two CLK32 periods */
>  			clocks = <&clks 18>;
>  			clock-names = "cpu";
> +			voltage-tolerance = <1>;
>  		};
>  	};
>  
> -- 
> 1.8.1.5
> 
