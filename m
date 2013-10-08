From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Oct 2013 14:37:27 +0800
Subject: [PATCH] ARM: imx27-apf27dev: Add framebuffer support
In-Reply-To: <1381068474-30763-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1381068474-30763-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20131008063725.GD7480@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 06, 2013 at 04:07:54PM +0200, Gwenhael Goavec-Merou wrote:
> 
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx27-apf27dev.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index 2a377ca..47c8c26 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -16,6 +16,26 @@
>  	model = "Armadeus Systems APF27Dev docking/development board";
>  	compatible = "armadeus,imx27-apf27dev", "armadeus,imx27-apf27", "fsl,imx27";
>  
> +	display: display {
> +		model = "Chimei-LW700AT9003";
> +		native-mode = <&timing0>;
> +		bits-per-pixel = <16>;  /* non-standard but required */
> +		fsl,pcr = <0xfae80083>;	/* non-standard but required */
> +		display-timings {
> +			timing0: 640x480 {
> +				clock-frequency = <33000033>;
> +				hactive = <800>;
> +				vactive = <640>;
> +				hback-porch = <96>;
> +				hfront-porch = <96>;
> +				vback-porch = <20>;
> +				vfront-porch = <21>;
> +				hsync-len = <64>;
> +				vsync-len = <4>;
> +			};
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> @@ -50,6 +70,12 @@
>  	status = "okay";
>  };
>  
> +&fb {
> +	display = <&display>;
> +	fsl,dmacr = <0x00020010>;
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	status = "okay";
> -- 
> 1.8.1.5
> 
