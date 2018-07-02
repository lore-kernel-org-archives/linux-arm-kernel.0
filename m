From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 2 Jul 2018 18:56:47 +0200
Subject: [PATCH 4/6] arm64: dts: mediatek: Add missing cooling device
 properties for CPUs
In-Reply-To: <49b1086c104b0ee22f6e992a0abb380de9320c09.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <49b1086c104b0ee22f6e992a0abb380de9320c09.1527225682.git.viresh.kumar@linaro.org>
Message-ID: <003321e5-3d47-9626-ee65-be5abd54a3ae@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/05/18 07:40, Viresh Kumar wrote:
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

pushed now to v4.18-next/dts64

> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 9213c966c224..d49fe125e770 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -89,6 +89,7 @@
>  				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
>  			clock-names = "cpu", "intermediate";
>  			operating-points-v2 = <&cpu_opp_table>;
> +			#cooling-cells = <2>;
>  			enable-method = "psci";
>  			clock-frequency = <1300000000>;
>  		};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 94597e33c806..abd2f15a544b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -168,6 +168,7 @@
>  			reg = <0x001>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			#cooling-cells = <2>;
>  			clocks = <&infracfg CLK_INFRA_CA53SEL>,
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
> @@ -193,6 +194,7 @@
>  			reg = <0x101>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			#cooling-cells = <2>;
>  			clocks = <&infracfg CLK_INFRA_CA57SEL>,
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
> 
