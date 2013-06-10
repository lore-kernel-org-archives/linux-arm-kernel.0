From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 10 Jun 2013 16:19:47 +0100
Subject: [PATCH] ARM: dts: add missing cpu #address-cell values
In-Reply-To: <2030747.zTCiG7VMcH@wuerfel>
References: <2030747.zTCiG7VMcH@wuerfel>
Message-ID: <20130610151947.GA1310@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 03:52:34PM +0100, Arnd Bergmann wrote:
> A recent series has added CPU numbers to a lot of dts files,
> but unfortunately in a few cases the #address-cells
> and #size-cells values are missing, which causes build warnings.
> This adds the missing ones for sunxi and sama5 that I found
> through build testing.

Gah, my bad, apologies, I missed the #address/#size cells updates to new
dts that were merged the last merge window after rebasing, really sorry about
that.

Thanks !
Lorenzo

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
> I've applied this on top of the next/dt branch that has the original
> patches.
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index abdf1c8..f57ffbc 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -38,6 +38,8 @@
>  		ssc1 = &ssc1;
>  	};
>  	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		cpu at 0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a5";
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 39a8f61..06ef8b6 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -16,6 +16,8 @@
>  	interrupt-parent = <&intc>;
>  
>  	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		cpu at 0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a8";
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index 00a2637d..d285254 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -17,6 +17,8 @@
>  	interrupt-parent = <&intc>;
>  
>  	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		cpu at 0 {
>  			device_type = "cpu";
>  			compatible = "arm,cortex-a8";
> 
> 
> 
