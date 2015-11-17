From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Nov 2015 13:30:46 -0600
Subject: [PATCH 5/7] Documentation: bindings: Add SMP related documentation
In-Reply-To: <1447772202-12418-6-git-send-email-carlo@caione.org>
References: <1447772202-12418-1-git-send-email-carlo@caione.org>
 <1447772202-12418-6-git-send-email-carlo@caione.org>
Message-ID: <20151117193046.GA31149@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 03:56:40PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>

Please give some indication in the subject what platform this change is 
for:

dt-bindings: amlogic: ...

> 
> With this patch we add documentation for:
> 
> * power-management-unit: the PMU is used to bring up the cores during
>   SMP operations
> * sram: among other things the sram is used to store the first code
>   executed by the core when it is powered up
> * cpu-enable-method: the CPU enable method used by Amlogic Meson8b SoCs
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  .../devicetree/bindings/arm/amlogic/pmu.txt        | 16 +++++++
>  .../devicetree/bindings/arm/amlogic/smp-sram.txt   | 32 +++++++++++++
>  .../arm/cpu-enable-method/amlogic,meson8b-smp      | 53 ++++++++++++++++++++++


> diff --git a/Documentation/devicetree/bindings/arm/cpu-enable-method/amlogic,meson8b-smp b/Documentation/devicetree/bindings/arm/cpu-enable-method/amlogic,meson8b-smp
> new file mode 100644
> index 0000000..95ee458b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpu-enable-method/amlogic,meson8b-smp
> @@ -0,0 +1,53 @@
> +=========================================================
> +Secondary CPU enable-method "amlogic,meson8b-smp" binding
> +=========================================================
> +
> +This document describes the "amlogic,meson8b-smp" method for enabling secondary
> +CPUs. To apply to all CPUs, a single "amlogic,meson8b-smp" enable method should
> +be defined in the "cpus" node.
> +
> +Enable method name:	"amlogic,meson8b-smp"

Just add this to Documentation/devicetree/bindings/arm/cpus.txt and 
remove this file.

> +Compatible machines:	"amlogic,meson8b"
> +Compatible CPUs:	"arm,cortex-a5"
> +Related properties:	(none)
> +
> +Example:
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		enable-method = "amlogic,meson8b-smp";
> +
> +		cpu at 200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a5";
> +			next-level-cache = <&L2>;
> +			reg = <0x200>;
> +			resets = <&clkc RST_CORE0>;
> +		};
> +
> +		cpu at 201 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a5";
> +			next-level-cache = <&L2>;
> +			reg = <0x201>;
> +			resets = <&clkc RST_CORE1>;
> +		};
> +
> +		cpu at 202 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a5";
> +			next-level-cache = <&L2>;
> +			reg = <0x202>;
> +			resets = <&clkc RST_CORE2>;
> +		};
> +
> +		cpu at 203 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a5";
> +			next-level-cache = <&L2>;
> +			reg = <0x203>;
> +			resets = <&clkc RST_CORE3>;
> +		};
> +	};
> +
> -- 
> 2.5.0
> 
