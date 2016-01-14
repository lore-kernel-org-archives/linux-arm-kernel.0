From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 14 Jan 2016 14:47:12 +0000
Subject: [RFC PATCH 3/5] arm64: dts: Add Cavium ThunderX specific PMU
In-Reply-To: <9b05a1866d37f3c1af0c6ae5835df810342ff558.1452766568.git.jglauber@cavium.com>
References: <cover.1452766568.git.jglauber@cavium.com>
 <9b05a1866d37f3c1af0c6ae5835df810342ff558.1452766568.git.jglauber@cavium.com>
Message-ID: <20160114144711.GC27039@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As it's the middle of the merge window, it will be a while before this
sees a full review. In future, it would be better to wait until -rc1
before posting new patches (appropriately rebased).

I did spot one thing however.

On Thu, Jan 14, 2016 at 01:55:43PM +0100, Jan Glauber wrote:
> Add a compatible string for the Cavium ThunderX PMU.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.txt | 1 +
>  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi  | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.txt b/Documentation/devicetree/bindings/arm/pmu.txt
> index 5651883..9bd0a33 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/pmu.txt
> @@ -25,6 +25,7 @@ Required properties:
>  	"qcom,scorpion-pmu"
>  	"qcom,scorpion-mp-pmu"
>  	"qcom,krait-pmu"
> +	"cavium,thunderx-pmu"
>  - interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
>                 interrupt (PPI) then 1 interrupt should be specified.
>  
> diff --git a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> index 9cb7cf9..84ac556 100644
> --- a/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> +++ b/arch/arm64/boot/dts/cavium/thunder-88xx.dtsi
> @@ -360,6 +360,11 @@
>  		             <1 10 0xff01>;
>  	};
>  
> +	pmu {
> +		compatible = "cavium,thunderx-pmu", "arm,armv8-pmuv3";

In current dts, "cavium,thunder" is used as the CPU compatible string.

Please decide whether you want to call the CPU "Thunder", or
"Thunder-X", and ensure that all compatible strings are consistent.

Please also ansure that any related names exposes to userspace (i.e.
e.g. the PMU name) follow this consistent naming.

Thanks,
Mark.

> +		interrupts = <1 7 4>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> -- 
> 1.9.1
> 
