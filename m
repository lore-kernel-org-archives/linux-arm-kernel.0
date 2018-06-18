From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 18 Jun 2018 16:39:20 +0530
Subject: [PATCH] ARM: dts: exynos: Add missing CPU clocks to secondary
 CPUs on Exynos542x
In-Reply-To: <20180530164922.31851-1-krzk@kernel.org>
References: <20180530164922.31851-1-krzk@kernel.org>
Message-ID: <CANAwSgSv4yWD6p4OTQV+Ua9PuL=M4KYAgOtwdXCD8S0X-cx+tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,


On 30 May 2018 at 22:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Secondary CPUs should have the same information in DeviceTree as booting
> CPU from both correctness point of view and for possible hotplug
> scenarios.
>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5420-cpus.dtsi | 6 ++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> index a8e449471304..0ee6e92a3c29 100644
> --- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
> @@ -38,6 +38,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x1>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -49,6 +50,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x2>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -60,6 +62,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x3>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -83,6 +86,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x101>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -94,6 +98,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x102>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -105,6 +110,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x103>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> index 7c130a00d1a8..e4a5857c135f 100644
> --- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
> @@ -37,6 +37,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x101>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -48,6 +49,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x102>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -59,6 +61,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a7";
>                         reg = <0x103>;
> +                       clocks = <&clock CLK_KFC_CLK>;
>                         clock-frequency = <1000000000>;
>                         cci-control-port = <&cci_control0>;
>                         operating-points-v2 = <&cluster_a7_opp_table>;
> @@ -69,8 +72,8 @@
>                 cpu4: cpu at 0 {
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
> -                       clocks = <&clock CLK_ARM_CLK>;
>                         reg = <0x0>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -82,6 +85,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x1>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -93,6 +97,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x2>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> @@ -104,6 +109,7 @@
>                         device_type = "cpu";
>                         compatible = "arm,cortex-a15";
>                         reg = <0x3>;
> +                       clocks = <&clock CLK_ARM_CLK>;
>                         clock-frequency = <1800000000>;
>                         cci-control-port = <&cci_control1>;
>                         operating-points-v2 = <&cluster_a15_opp_table>;
> --
[snip]

Actually cpufreq module have more clock to be enabled below is example
from clk_summary.

    fout_kpll                             0            0  1400000000
       0 0
       mout_kpll                          0            0  1400000000
       0 0
          kfcclk                          0            0  1400000000
       0 0
          sclk_kpll                       0            0   350000000
       0 0
          mout_kfc                        0            0  1400000000
       0 0
             div_kfc                      0            0  1400000000
       0 0

    fout_apll                             0            0  2000000000
       0 0
       mout_apll                          0            0  2000000000
       0 0
          armclk                          0            0  2000000000
       0 0
          sclk_apll                       0            0   500000000
       0 0
          mout_cpu                        0            0  2000000000
       0 0
             div_arm                      0            0  2000000000
       0 0
                armclk2                   0            0  2000000000
       0 0

Best Regards
-Anand
