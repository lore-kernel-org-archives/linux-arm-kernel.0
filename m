From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 25 Jun 2018 16:58:04 +0200
Subject: [PATCH 03/15] arm: dts: mediatek: Add missing cooling device
 properties for CPUs
In-Reply-To: <b687bb6035fbb010383f4511a206abb4006679fa.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <b687bb6035fbb010383f4511a206abb4006679fa.1527244201.git.viresh.kumar@linaro.org>
Message-ID: <186ed0b1-e365-4b3d-5c50-613d8353708b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 12:31, Viresh Kumar wrote:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
> 
> Add such missing properties.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

pushed to v4.18-next/dts32

Thanks

> ---
>  arch/arm/boot/dts/mt7623.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
> index d1eb123bc73b..1cdc346a05e8 100644
> --- a/arch/arm/boot/dts/mt7623.dtsi
> +++ b/arch/arm/boot/dts/mt7623.dtsi
> @@ -92,6 +92,7 @@
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  			clock-frequency = <1300000000>;
>  		};
>  
> @@ -103,6 +104,7 @@
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  			clock-frequency = <1300000000>;
>  		};
>  
> @@ -114,6 +116,7 @@
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  			clock-frequency = <1300000000>;
>  		};
>  	};
> 
