From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 19 Mar 2018 00:49:46 +0100
Subject: [PATCH v1 09/19] arm: dts: mt7623: add related clock properties
 to cpu[1-3] nodes
In-Reply-To: <8cfae2c1d9464cf82e431a6e0c7c275c46133578.1519378872.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <8cfae2c1d9464cf82e431a6e0c7c275c46133578.1519378872.git.sean.wang@mediatek.com>
Message-ID: <a24cd8dc-76ef-e57a-0f6e-7305e1946a23@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/23/2018 11:16 AM, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Complement the missing clock properties cpu[1-3] should depend on.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm at vger.kernel.org

Pushed to v4.16-next/dts32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index da56c54..5cf93a4 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -94,6 +94,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x1>;
> +			clocks = <&infracfg CLK_INFRA_CPUSEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clock-frequency = <1300000000>;
>  		};
> @@ -102,6 +105,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x2>;
> +			clocks = <&infracfg CLK_INFRA_CPUSEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clock-frequency = <1300000000>;
>  		};
> @@ -110,6 +116,9 @@
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a7";
>  			reg = <0x3>;
> +			clocks = <&infracfg CLK_INFRA_CPUSEL>,
> +				 <&apmixedsys CLK_APMIXED_MAINPLL>;
> +			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clock-frequency = <1300000000>;
>  		};
> 
