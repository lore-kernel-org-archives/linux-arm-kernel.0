From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 14 May 2014 21:50:44 +0200
Subject: [PATCH v4 3/5] ARM: dts: enable hdmi for exynos5420 based
 peach-pit board
In-Reply-To: <1400035562-16832-4-git-send-email-rahul.sharma@samsung.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
 <1400035562-16832-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <5373C914.1050909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 14.05.2014 04:46, Rahul Sharma wrote:
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Enable hdmi for exynos5420 based peach-pit board.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   19 +++++++++++++++++++
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi  |    7 +++++++
>  arch/arm/boot/dts/exynos5420.dtsi          |    5 +++++
>  3 files changed, 31 insertions(+)

[snip]

> diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> index ba686e4..fc17797 100644
> --- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
> @@ -66,6 +66,13 @@
>  			samsung,pin-pud = <0>;
>  			samsung,pin-drv = <0>;
>  		};
> +
> +		hdmi_hpd_irq: hdmi-hpd-irq {
> +			samsung,pins = "gpx3-7";
> +			samsung,pin-function = <0>;
> +			samsung,pin-pud = <1>;
> +			samsung,pin-drv = <0>;

Same comment as for patch 1/5.

> +		};
>  	};
>  
>  	pinctrl at 13410000 {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 016992c..df4422c 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -648,9 +648,14 @@
>  			 <&clock CLK_MOUT_HDMI>;
>  		clock-names = "hdmi", "sclk_hdmi", "sclk_pixel",
>  			"sclk_hdmiphy", "mout_hdmi";
> +		phy = <&hdmiphy>;
>  		status = "disabled";
>  	};
>  
> +	hdmiphy: hdmiphy at 145D0000 {
> +		reg = <0x145D0000 0x20>;
> +	};

Hmm, this doesn't seem like a proper device node and I don't see other
properties present in exynos5.dtsi either. Are all the necessary patches
already merged in linux-next?

Best regards,
Tomasz
