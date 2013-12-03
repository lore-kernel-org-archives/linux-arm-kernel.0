From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 03 Dec 2013 12:52:36 +0100
Subject: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <529DC604.4050600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 05:20 PM, Lorenzo Pieralisi wrote:
> ARM based platforms implement a variety of power management schemes that
> allow processors to enter at run-time low-power states, aka C-states
> in ACPI jargon. The parameters defining these C-states vary on a per-platform
> basis forcing the OS to hardcode the state parameters in platform
> specific static tables whose size grows as the number of platforms supported
> in the kernel increases and hampers device drivers standardization.
>
> Therefore, this patch aims at standardizing C-state device tree bindings for
> ARM platforms. Bindings define C-state parameters inclusive of entry methods
> and state latencies, to allow operating systems to retrieve the
> configuration entries from the device tree and initialize the related
> power management drivers, paving the way for common code in the kernel
> to deal with power states and removing the need for static data in current
> and previous kernel versions.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Lorenzo,

thanks for the detailed description.

Just a couple of typos below.

[ ... ]

> +- cpu-power-states node
> +
> +	Usage: Optional - On ARM systems, is a container of processor C-state
> +			  nodes. If the system does not provide CPU power
> +			  management capabilities or the processor just
> +			  supports WFI (C1 state) a cpu-power-states node is
> +			  not required.
> +
> +	Description: cpu-power-states node is a container node, where its
> +		     subnodes describe the CPU low-power C-states.
> +
> +	Node name must be "cpu-power-states".
> +
> +	The cpu-power-states node's parent node must be cpus node.
> +
> +	The cpu-power-states node's child nodes can be:
> +
> +	- one or more state nodes
> +
> +	The cpu-power-states node must contain the following properties:
> +
> +	- compatible
> +		Value type: <stringlist>
> +		Usage: Required

Invert the field above to be consistent with the definitions below.

[ ... ]

> +	- power-depth
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: Integer value, starting from 2 (value 0 meaning
> +			    running and value 1 representing power depth of
> +			    wfi (C1)), that defines the level of depth of a
> +			    power state.
> +			    The system denotes power states with different
> +			    depths, an increasing value meaning less power
> +			    consumption and might involve powering down more
> +			    components.  Devices that are affected by

                                     ^^^ extra space

[ ... ]

Thanks
   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
