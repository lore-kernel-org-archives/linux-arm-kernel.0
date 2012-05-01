From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 1 May 2012 20:55:14 +0800
Subject: [PATCH 11/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
In-Reply-To: <1335510185-7906-12-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-12-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120501125512.GG2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 03:03:05PM +0800, Richard Zhao wrote:
> From: Richard Zhao <richard.zhao@linaro.org>
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index cdae2dd..20aa767 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -97,4 +97,17 @@
>  			regulator-always-on;
>  		};
>  	};
> +
> +	sound {
> +		compatible = "fsl,imx6q-sabrelite-sgtl5000",
> +			     "fsl,imx-audio-sgtl5000";
> +		model = "imx6q-sabrelite-sgtl5000";
> +		ssi-controller = <&ssi1>;
> +		audio-codec = <&codec>;
> +		audio-routing =
> +			"MIC_IN", "Mic Jack",

Just curious if you have capture working without enabling Mic Bias
power supplier.

Regards,
Shawn

> +			"Headphone Jack", "HP_OUT";
> +		mux-int-port = <1>;
> +		mux-ext-port = <4>;
> +	};
>  };
> -- 
> 1.7.5.4
> 
> 
