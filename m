From: linux@prisktech.co.nz (Tony Prisk)
Date: Tue, 23 Apr 2013 14:46:36 +1200
Subject: [RFC PATCH v2 13/13] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <1366644455-16550-14-git-send-email-lorenzo.pieralisi@arm.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-14-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <5175F60C.1070508@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/04/13 03:27, Lorenzo Pieralisi wrote:
> +
> +=====================================
> +cpus and cpu node bindings definition
> +=====================================
> +
> +The ARM architecture, in accordance with the ePAPR, requires the cpus and cpu
> +nodes to be present and contain the properties described below.
> +
> +- cpus node
> +
> +	Description: Container of cpu nodes
> +
> +	The node name must be "cpus".
> +
> +	A cpus node must define the following properties:
> +
> +	- #address-cells
> +		Usage: required
> +		Value type: <u32>
> +		Definition: must be set to 1 for 32-bit systems and 2 for
> +			    64-bit systems
> +	- #size-cells
> +		Usage: required
> +		Value type: <u32>
> +		Definition: must be set to 0
> +
...
> +Example 3 (ARM 1176 uniprocessor 32-bit system):
> +
> +	cpus {
> +		cpu {
> +			device_type = "cpu";
> +			compatible = "arm,arm1176";
> +		};
> +	};
> +
This example is missing the required #size-cells and #address-cells 
properties.

Regards
Tony P
