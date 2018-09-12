From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Sep 2018 09:22:54 +0800
Subject: [PATCH] ARM: dts: imx53-qsb: disable 1.2GHz OPP
In-Reply-To: <20180910125056.30813-1-s.hauer@pengutronix.de>
References: <20180910125056.30813-1-s.hauer@pengutronix.de>
Message-ID: <20180912012252.GE28469@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 02:50:56PM +0200, Sascha Hauer wrote:
> The maximum CPU frequency for the i.MX53 QSB is 1GHz, so disable the
> 1.2GHz OPP. This makes the board work with cpufreq again.

I feel that the word 'again' and the Fixes tag below are a little
confusing.  It makes impression that cpufreq worked fine on the board
before and commit 791f416608 broke it.  However, this is not the case,
right?

> 
> Fixes: 791f416608 ("ARM: dts: imx53: add cpufreq-dt support")

Shawn

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx53-qsb-common.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
> index 7423d462d1e4..50dde84b72ed 100644
> --- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
> +++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
> @@ -123,6 +123,17 @@
>  	};
>  };
>  
> +&cpu0 {
> +	/* CPU rated to 1GHz, not 1.2GHz as per the default settings */
> +	operating-points = <
> +		/* kHz   uV */
> +		166666  850000
> +		400000  900000
> +		800000  1050000
> +		1000000 1200000
> +	>;
> +};
> +
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> -- 
> 2.18.0
> 
