From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 29 Mar 2016 07:40:41 -0700
Subject: [PATCH 09/12] ARM: dts: dragonboard-600c: add on board sata
 support.
In-Reply-To: <1458762477-9722-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1458762366-9233-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1458762477-9722-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160329144041.GM8929@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 23 Mar 12:47 PDT 2016, Srinivas Kandagatla wrote:

> This patch enables sata and regulators required to get on board sata
> working.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
> index d3e6193..52f742c 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-dragonboard-600c.dts
> @@ -135,6 +135,10 @@
>  				lvs6 {
>  					bias-pull-down;
>  				};
> +
> +				lvs7 {
> +					bias-pull-down;
> +				};
>  			};
>  		};
>  
> @@ -171,6 +175,15 @@
>  			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
>  		};
>  
> +		phy at 1b400000 {
> +			status = "okay";
> +		};
> +
> +		sata at 29000000 {
> +			status	= "okay";
> +			target-supply	= <&pm8921_lvs7>;
> +		};
> +
>  		/* OTG */
>  		phy at 12500000 {
>  			status		= "okay";
> -- 
> 2.5.0
> 
