From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 11 Jan 2018 08:38:30 +0800
Subject: [PATCH] arm64: dts: add #cooling-cells to CPU nodes
In-Reply-To: <20180110210706.2331225-1-arnd@arndb.de>
References: <20180110210706.2331225-1-arnd@arndb.de>
Message-ID: <1515631110.19513.5.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-01-10 at 22:06 +0100, Arnd Bergmann wrote:
> dtc complains about the lack of #coolin-cells properties for the
> CPU nodes that are referred to as "cooling-device":
> 
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu at 0 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map at 0:cooling-device[0])
> arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: Warning (cooling_device_property): Missing property '#cooling-cells' in node /cpus/cpu at 100 or bad phandle (referred from /thermal-zones/cpu_thermal/cooling-maps/map at 1:cooling-device[0])
> 
> Apparently this property must be '<2>' to match the binding.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If this looks ok, I'd apply it directly to the fixes branch
> for 4.15, as the warning is one that was introduced in this
> release.
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index b477ad790071..9fbe4705ee88 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -155,6 +155,7 @@
>  			reg = <0x000>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			#cooling-cells = <2>;
>  			clocks = <&infracfg CLK_INFRA_CA53SEL>,
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";
> @@ -179,6 +180,7 @@
>  			reg = <0x100>;
>  			enable-method = "psci";
>  			cpu-idle-states = <&CPU_SLEEP_0>;
> +			#cooling-cells = <2>;
>  			clocks = <&infracfg CLK_INFRA_CA57SEL>,
>  				 <&apmixedsys CLK_APMIXED_MAINPLL>;
>  			clock-names = "cpu", "intermediate";

Tested-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
