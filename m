From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 8 Jan 2012 17:06:21 +0800
Subject: [PATCH 3/6] arm/dts: imx6q-sabrelite: add 2P5V and 3P3V regulators
In-Reply-To: <1325820343-11875-4-git-send-email-richard.zhao@linaro.org>
References: <1325820343-11875-1-git-send-email-richard.zhao@linaro.org>
 <1325820343-11875-4-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120108090619.GB20216@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For subject, I would suggest something like below to keep consistency
with code patches.

ARM: dts: imx6q-sabrelite: ...

On Fri, Jan 06, 2012 at 11:25:40AM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 08d920d..3f4b45e 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -46,4 +46,24 @@
>  			};
>  		};
>  	};
> +
> +	regulators {

Shouldn't this node be under node 'anatop at 020c8000'?

> +		compatible = "simple-bus";
> +
Hmm, do we really need this?

> +		reg_2P5V: regulator-2P5V {

There is convention that we should try to have all kinds of names in dts
as lower case, even though hardware document generally names blocks in
capital letters.  It just looks odd to have mixed cases in the name.

Since the node is under node 'regulators', we may name the node just
as simple as '2p5v'.

> +			compatible = "regulator-fixed";
> +			regulator-name = "2P5V";

It's fine to use capital letters for such case.

Regards,
Shawn

> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <2500000>;
> +			regulator-always-on;
> +		};
> +
> +		reg_3P3V: regulator-3P3V {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
>  };
> -- 
> 1.7.5.4
