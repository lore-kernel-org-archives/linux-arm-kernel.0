From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 13:34:25 +0800
Subject: [PATCH 4/7] ARM i.MX6q: Link system reset controller (SRC) to
 IPU in DT
In-Reply-To: <1358352787-15441-5-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
 <1358352787-15441-5-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130117053424.GJ26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 05:13:04PM +0100, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index d6265ca..c445959 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -555,6 +555,7 @@
>  				compatible = "fsl,imx6q-src";
>  				reg = <0x020d8000 0x4000>;
>  				interrupts = <0 91 0x04 0 96 0x04>;
> +				#reset-cells = <1>;
>  			};
>  
>  			gpc: gpc at 020dc000 {
> @@ -1046,6 +1047,7 @@
>  			interrupts = <0 6 0x4 0 5 0x4>;
>  			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
>  			clock-names = "bus", "di0", "di1";
> +			resets = <&src 2>;
>  		};
>  
>  		ipu2: ipu at 02800000 {
> @@ -1055,6 +1057,7 @@
>  			interrupts = <0 8 0x4 0 7 0x4>;
>  			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
>  			clock-names = "bus", "di0", "di1";
> +			reset = <&src 4>;

s/reset/resets

Shawn

>  		};
>  	};
>  };
> -- 
> 1.7.10.4
> 
