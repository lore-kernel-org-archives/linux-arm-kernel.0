From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Jul 2018 10:22:05 +0530
Subject: [PATCH 1/1] ARM: dts: imx6ull: add operating points
In-Reply-To: <20180629145221.10393-1-sebastien.szymanski@armadeus.com>
References: <20180629145221.10393-1-sebastien.szymanski@armadeus.com>
Message-ID: <20180702045205.fdh4dwwhwyfftptl@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-18, 16:52, S?bastien Szymanski wrote:
> i.MX6ULL has different operating ranges than i.MX6UL so add the
> operating points for the i.MX6ULL and removed them form board device

s/removed/remove/
s/form/from/

> trees. A 25mV offset is added to the minimum allowed values like for the
> i.MX6UL.
> The valid frequencies are now selected by the cpufreq driver according
> to ratings stored in fuses since commit 0aa9abd4c212 ("cpufreq: imx6q:
> check speed grades for i.MX6ULL")
> 
> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>  arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi | 14 --------------
>  arch/arm/boot/dts/imx6ull.dtsi              | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> index 3dffbcd50bf6..183193e8580d 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
> @@ -20,20 +20,6 @@
>  
>  &cpu0 {
>  	clock-frequency = <792000000>;
> -	operating-points = <
> -		/* kHz	uV */
> -		792000  1225000
> -		528000	1175000
> -		396000	1025000
> -		198000	950000
> -	>;
> -	fsl,soc-operating-points = <
> -		/* KHz	uV */
> -		792000  1175000
> -		528000	1175000
> -		396000	1175000
> -		198000	1175000
> -	>;
>  };
>  
>  &iomuxc {
> diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
> index ebc25c98e5e1..ade64bd46fab 100644
> --- a/arch/arm/boot/dts/imx6ull.dtsi
> +++ b/arch/arm/boot/dts/imx6ull.dtsi
> @@ -48,6 +48,25 @@
>  /* Delete CAAM node in AIPS-2 (i.MX6UL specific) */
>  /delete-node/ &crypto;
>  
> +&cpu0 {
> +	operating-points = <
> +		/* kHz	uV */
> +		900000	1275000
> +		792000	1225000
> +		528000	1175000
> +		396000	1025000
> +		198000	950000
> +	>;
> +	fsl,soc-operating-points = <
> +		/* KHz	uV */
> +		900000	1175000
> +		792000	1175000
> +		528000	1175000
> +		396000	1175000
> +		198000	1175000
> +	>;
> +};
> +
>  / {
>  	soc {
>  		aips3: aips-bus at 2200000 {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
