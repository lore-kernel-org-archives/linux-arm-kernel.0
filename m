From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Mar 2013 11:13:26 +0800
Subject: [PATCH V4 6/9] ARM: mxs: Provide regulator to pwm-backlight
In-Reply-To: <1363719573-20926-7-git-send-email-achew@nvidia.com>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-7-git-send-email-achew@nvidia.com>
Message-ID: <20130320031324.GB26941@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:59:30AM -0700, Andrew Chew wrote:
> The pwm-backlight driver now takes a mandatory regulator that is gotten
> during driver probe.  Initialize a dummy regulator to satisfy this
> requirement.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
> ---
>  arch/arm/boot/dts/imx23-evk.dts      | 6 ++++++
>  arch/arm/boot/dts/imx28-apf28dev.dts | 6 ++++++
>  arch/arm/boot/dts/imx28-cfa10049.dts | 6 ++++++
>  arch/arm/boot/dts/imx28-evk.dts      | 6 ++++++
>  arch/arm/boot/dts/imx28-tx28.dts     | 6 ++++++
>  5 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
> index 035c13f..e48e36c 100644
> --- a/arch/arm/boot/dts/imx23-evk.dts
> +++ b/arch/arm/boot/dts/imx23-evk.dts
> @@ -97,10 +97,16 @@
>  		};
>  	};
>  
> +	bl_en: fixed-regulator {

The node name is too generic.  Very likely we have other fixed regulator
in a dts.

For mxs, we have all such board level regulators defined in node
"regulators" as children.

Shawn

> +		compatible = "regulator-fixed";
> +		regulator-name = "bl-en-supply";
> +        };
> +
>  	backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pwm 2 5000000>;
>  		brightness-levels = <0 4 8 16 32 64 128 255>;
>  		default-brightness-level = <6>;
> +		enable-supply = <&bl_en>;
>  	};
>  };
