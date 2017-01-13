From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Jan 2017 18:43:52 +0000
Subject: [RFC PATCH v2 10/10] dt-bindings: Document devicetree binding
 for ARM SPE
In-Reply-To: <1484323429-15231-11-git-send-email-will.deacon@arm.com>
References: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
 <1484323429-15231-11-git-send-email-will.deacon@arm.com>
Message-ID: <20170113184352.GE2472@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 04:03:49PM +0000, Will Deacon wrote:
> This patch documents the devicetree binding in use for ARM SPE.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/spe-pmu.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/spe-pmu.txt b/Documentation/devicetree/bindings/arm/spe-pmu.txt
> new file mode 100644
> index 000000000000..d6540b491af4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/spe-pmu.txt
> @@ -0,0 +1,20 @@
> +* ARMv8.2 Statistical Profiling Extension (SPE) Performance Monitor Units (PMU)
> +
> +ARMv8.2 introduces the optional Statistical Profiling Extension for collecting
> +performance sample data using an in-memory trace buffer.
> +
> +** SPE Required properties:
> +
> +- compatible : should be one of:
> +	       "arm,arm-spe-pmu-v1"

The second "arm" here doesn't seem to add much. Should that be "armv8.2"
instead?

That would roughly match what we do with the architected timers to
describe the specific architectural version.

Otherwise, this looks fine to me.

Thanks,
Mark.

> +- interrupts : Exactly 1 PPI must be listed. For heterogeneous systems where
> +               SPE is only supported on a subset of the CPUs, please consult
> +	       the arm,gic-v3 binding for details on describing a PPI partition.
> +
> +** Example:
> +
> +spe-pmu {
> +        compatible = "arm,arm-spe-pmu-v1";
> +        interrupts = <GIC_PPI 05 IRQ_TYPE_EDGE_RISING &part1>;
> +};
> -- 
> 2.1.4
> 
