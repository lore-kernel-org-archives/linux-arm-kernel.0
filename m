From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 May 2015 00:32:03 -0500
Subject: [PATCH V5 3/3] OPP: Add binding for 'opp-suspend'
In-Reply-To: <618b02107af650bcb3246e165095bbca207d511a.1432091956.git.viresh.kumar@linaro.org>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <618b02107af650bcb3246e165095bbca207d511a.1432091956.git.viresh.kumar@linaro.org>
Message-ID: <555D6DD3.7000404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 10:41 PM, Viresh Kumar wrote:
> On few platforms, for power efficiency, we want the device to be
> configured for a specific OPP while we put the device in suspend state.
> 
> Add an optional property in operating-points-v2 bindings for that.

Why not just mark it as a property of an OPP rather than a phandle? just
thinking that this might setup a precedence for future needs like
"shutdown OPP" or "Reboot OPP" or something different that some other
SoC might have..

> 
> Suggested-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/opp.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentation/devicetree/bindings/power/opp.txt
> index 7f30d9b07db7..880f5e14b6e2 100644
> --- a/Documentation/devicetree/bindings/power/opp.txt
> +++ b/Documentation/devicetree/bindings/power/opp.txt
> @@ -72,6 +72,8 @@ This describes the OPPs belonging to a device. This node can have following
>    Missing property means devices have independent clock/voltage/current lines,
>    but they share OPP tables.
>  
> +- opp-suspend: Phandle of the OPP to set while device is suspended.
> +
>  
>  * OPP Node
>  
> @@ -143,9 +145,10 @@ Example 1: Single cluster Dual-core ARM cortex A9, switch DVFS states together.
>  
>  	cpu0_opp: opp0 {
>  		compatible = "operating-points-v2";
> +		opp-suspend = <&suspend_opp>;
>  		opp-shared;
>  
> -		entry00 {
> +		suspend-opp: entry00 {
>  			opp-hz = <1000000000>;
>  			opp-microvolt = <970000 975000 985000>;
>  			opp-microamp = <70000>;
> @@ -217,13 +220,14 @@ independently.
>  
>  	cpu0_opp: opp0 {
>  		compatible = "operating-points-v2";
> +		opp-suspend = <&suspend_opp>;
>  
>  		/*
>  		 * Missing opp-shared property means CPUs switch DVFS states
>  		 * independently.
>  		 */
>  
> -		entry00 {
> +		suspend-opp: entry00 {
>  			opp-hz = <1000000000>;
>  			opp-microvolt = <970000 975000 985000>;
>  			opp-microamp = <70000>;
> @@ -296,9 +300,10 @@ DVFS state together.
>  
>  	cluster0_opp: opp0 {
>  		compatible = "operating-points-v2";
> +		opp-suspend = <&suspend_opp0>;
>  		opp-shared;
>  
> -		entry00 {
> +		suspend-opp0: entry00 {
>  			opp-hz = <1000000000>;
>  			opp-microvolt = <970000 975000 985000>;
>  			opp-microamp = <70000>;
> @@ -321,9 +326,10 @@ DVFS state together.
>  
>  	cluster1_opp: opp1 {
>  		compatible = "operating-points-v2";
> +		opp-suspend = <&suspend_opp1>;
>  		opp-shared;
>  
> -		entry10 {
> +		suspend-opp1: entry10 {
>  			opp-hz = <1300000000>;
>  			opp-microvolt = <1045000 1050000 1055000>;
>  			opp-microamp = <95000>;
> 


-- 
Regards,
Nishanth Menon
