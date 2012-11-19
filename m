From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 19 Nov 2012 11:02:35 +0000
Subject: [PATCH v3 2/5] ARM: kernel: add device tree init map function
In-Reply-To: <1352983614-22924-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1352983614-22924-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1352983614-22924-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20121119110155.GA2816@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just a couple of comments on the binding documentation.

> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> new file mode 100644
> index 0000000..1fab07a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -0,0 +1,78 @@
> +* ARM CPUs binding description
> +
> +The device tree allows to describe the layout of CPUs in a system through
> +the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> +defining properties for every cpu.
> +
> +Bindings for CPU nodes follow the ePAPR standard, available from:
> +
> +http://devicetree.org
> +
> +For the ARM architecture every CPU node must contain the following properties:
> +
> +- reg:		property matching the CPU MPIDR[23:0] register bits
> +		reg[31:24] bits must be set to 0
> +- compatible:	should be one of:
> +		"arm,arm1020"
> +		"arm,arm1020e"
> +		"arm,arm1022"
> +		"arm,arm1026"
> +		"arm,arm720"
> +		"arm,arm740"
> +		"arm,arm7tdmi"
> +		"arm,arm920"
> +		"arm,arm922"
> +		"arm,arm925"
> +		"arm,arm926"
> +		"arm,arm940"
> +		"arm,arm946"
> +		"arm,arm9tdmi"
> +		"arm,cortex-a5"
> +		"arm,cortex-a7"
> +		"arm,cortex-a8"
> +		"arm,cortex-a9"
> +		"arm,cortex-a15"
> +		"arm,arm1136"
> +		"arm,arm1156"
> +		"arm,arm1176"
> +		"arm,arm11mpcore"
> +		"faraday,fa526"
> +		"intel,sa110"
> +		"intel,sa1100"
> +		"marvell,feroceon"
> +		"marvell,mohawk"
> +		"marvell,xsc3"
> +		"marvell,xscale"
> +
> +Every cpu node is required to set its device_type to "cpu".

Should this not be described at the start of the properties list? e.g:

	- device_type:	must be "cpu"

It'd be more consistent and harder to miss that way.

> +Example:
> +
> +	cpus {
> +		#size-cells = <0>;
> +		#address-cells = <1>;
> +
> +		CPU0: cpu at 0 {
> +			device_type = "cpu";
> +			compatible = <arm, cortex-a15>;
> +			reg = <0x0>;
> +		};
> +
> +		CPU1: cpu at 1 {
> +			device_type = "cpu";
> +			compatible = <arm, cortex-a15>;
> +			reg = <0x1>;
> +		};
> +
> +		CPU2: cpu at 100 {
> +			device_type = "cpu";
> +			compatible = <arm, cortex-a7>;
> +			reg = <0x100>;
> +		};
> +
> +		CPU3: cpu at 101 {
> +			device_type = "cpu";
> +			compatible = <arm, cortex-a7>;
> +			reg = <0x101>;
> +		};
> +	};

It looks like you missed the compatible strings here when fixing things up from
v2. They should be:

	compatible = "arm,cortex-a15";

and:

	compatible = "arm,cortex-a7";

Otherwise, looks good!

Thanks,
Mark
