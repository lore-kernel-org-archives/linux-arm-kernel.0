From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 May 2017 09:50:10 +0530
Subject: [PATCH 6/6] dt-bindings: cpufreq: enhance Mediatek cpufreq
 dt-binding document
In-Reply-To: <1493997974-17699-7-git-send-email-sean.wang@mediatek.com>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
 <1493997974-17699-7-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170508042010.GD17010@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-05-17, 23:26, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Update binding document to reflect the lastest driver logic and

The bindings don't follow the drivers but its the other way around. Don't
mention anything about the drivers in the bindings patches.

> add more examples guiding people how to use Mediatek cpufreq driver.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/cpufreq/cpufreq-mediatek.txt          | 170 ++++++++++++++++++++-
>  1 file changed, 167 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index 52b457c..0703927 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -1,4 +1,5 @@
> -Device Tree Clock bindins for CPU DVFS of Mediatek MT8173 SoC
> +Binding for Mediatek's CPUFreq driver
> +=====================================
>  
>  Required properties:
>  - clocks: A list of phandle + clock-specifier pairs for the clocks listed in clock names.
> @@ -9,6 +10,8 @@ Required properties:
>  			  transition and not stable yet.
>  	Please refer to Documentation/devicetree/bindings/clk/clock-bindings.txt for
>  	generic clock consumer properties.
> +- operating-points-v2: Pleaser refer to Documentation/devicetree/bindings/opp/opp.txt
> +	for detail.
>  - proc-supply: Regulator for Vproc of CPU cluster.
>  
>  Optional properties:
> @@ -17,9 +20,166 @@ Optional properties:
>  	       Vsram to fit SoC specific needs. When absent, the voltage scaling
>  	       flow is handled by hardware, hence no software "voltage tracking" is
>  	       needed.
> +- #cooling-cells:
> +- cooling-min-level:
> +- cooling-max-level:
> +	Please refer to Documentation/devicetree/bindings/thermal/thermal.txt
> +	for detail.
> +
> +Example 1 (MT7623 SoC):
> +
> +	cpu_opp_table: opp_table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp at 598000000 {

s/opp@/opp-/

-- 
viresh
