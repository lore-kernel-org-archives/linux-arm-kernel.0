From: robherring2@gmail.com (Rob Herring)
Date: Fri, 13 Sep 2013 16:07:11 -0500
Subject: [PATCH 2/2] Documentation: DT: arm: define CPU topology bindings
In-Reply-To: <1376559743-31848-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1376559743-31848-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1376559743-31848-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <52337E7F.9010802@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 04:42 AM, Lorenzo Pieralisi wrote:
> The advent of multi-cluster ARM systems requires a mechanism to describe
> how in hierarchical terms CPUs are connected in ARM SoCs so that the kernel
> can initialize and map resources like IRQs and memory space to specific
> group(s) of CPUs.
> 
> The CPU topology is made up of multiple hierarchy levels whose bottom
> layers (aka leaf nodes in device tree syntax) contain links to the HW
> CPUs in the system.
> 
> The topology bindings are generic for both 32-bit and 64-bit systems and
> lay the groundwork on top of which affinity schemes can be built.

By affinity schemes, you mean further bindings? Do we need this binding
until that point?

As is, I don't have much comment.

[snip]

> +Example 3 (ARM 32-bit, cortex-a8 single core):
> +
> +cpus {
> +	#size-cells = <0>;
> +	#address-cells = <1>;
> +
> +	cpu-map {
> +		cluster0 {
> +			core0 {
> +				cpu = <&CPU0>;
> +			};
> +		};
> +	};

This example seems utterly pointless. I think we should be specific that
single core does not contain a cpu-map. I suppose we could have a
threaded, single core case, but let's address that if we ever do.

Rob

> +
> +	CPU0: cpu at 0 {
> +		device_type = "cpu";
> +		compatible = "arm,cortex-a8";
> +		reg = <0x0>;
> +	};
> +};
> +
> +===============================================================================
> +[1] ARM Linux kernel documentation
> +    Documentation/devicetree/bindings/arm/cpus.txt
> 
