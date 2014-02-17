From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Feb 2014 10:13:56 +0800
Subject: [PATCH 2/2] ARM: dts: imx6qdl-sabresd: Provide min/max voltages
 for codec regulator
In-Reply-To: <1392306839-10736-2-git-send-email-fabio.estevam@freescale.com>
References: <1392306839-10736-1-git-send-email-fabio.estevam@freescale.com>
 <1392306839-10736-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20140217021354.GD9879@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 01:53:59PM -0200, Fabio Estevam wrote:
> Currently the following message is observed during boot:
> 
> wm8962-supply: no parameters
> 
> Provide min/max properties for the codec regulator.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index a802265..086f770 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -47,6 +47,8 @@
>  			compatible = "regulator-fixed";
>  			reg = <2>;
>  			regulator-name = "wm8962-supply";
> +			regulator-min-microvolt = <4200000>;
> +			regulator-max-microvolt = <4200000>;

I guess they were omitted on purpose, because it's a backed up by a
number of supplies at different voltages.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/244470/focus=244475

>  			gpio = <&gpio4 10 0>;
>  			enable-active-high;
>  		};
> -- 
> 1.8.1.2
> 
> 
