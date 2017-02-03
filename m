From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 3 Feb 2017 10:56:57 -0600
Subject: [PATCH 2/2] DTS: dra7: Add "opp_high" opp node to support 1.5 GHz
 SoC operation
In-Reply-To: <1486135491-14223-2-git-send-email-lukma@denx.de>
References: <1486135491-14223-1-git-send-email-lukma@denx.de>
 <1486135491-14223-2-git-send-email-lukma@denx.de>
Message-ID: <e398ff96-dca7-7934-70b1-9a95c01d3b27@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2017 09:24 AM, Lukasz Majewski wrote:
> The "opp_high" property brings support for 1.5 GHz CPU frequency for TI's
> am57xx line of processors.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>

This can't be blindly enabled for all am57xx SoCs, there is a forthcoming 
ti-cpufreq [1] driver that is needed that will decided which OPPs can and cannot 
be enabled for the specific variant in use.

Regards,
Dave

[1] http://www.spinics.net/lists/devicetree/msg158967.html

> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index a860a56..5e678cd 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -108,6 +108,11 @@
>  			opp-hz = /bits/ 64 <1176000000>;
>  			opp-microvolt = <1160000 885000 1160000>;
>  		};
> +
> +		opp_high at 1500000000 {
> +			opp-hz = /bits/ 64 <1500000000>;
> +			opp-microvolt = <1210000 950000 1250000>;
> +		};
>  	};
>
>  	/*
>
