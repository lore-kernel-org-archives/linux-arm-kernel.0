From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Oct 2017 11:07:00 +0100
Subject: [PATCH v5 7/7] dt-bindings: Document devicetree binding for ARM
 SPE
In-Reply-To: <1506607791-8621-8-git-send-email-will.deacon@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-8-git-send-email-will.deacon@arm.com>
Message-ID: <20171002100700.GD20737@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 03:09:51PM +0100, Will Deacon wrote:
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
> index 000000000000..93372f2a7df9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/spe-pmu.txt
> @@ -0,0 +1,20 @@
> +* ARMv8.2 Statistical Profiling Extension (SPE) Performance Monitor Units (PMU)
> +
> +ARMv8.2 introduces the optional Statistical Profiling Extension for collecting
> +performance sample data using an in-memory trace buffer.

It might make sense to comment that even if described in the DT, a
higher exception level may disallow access (discoverable via
PMBIDR_EL1).

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

As a nit, this should've come before the driver, as per
Documentation/devicetree/bindings/submitting-patches.txt, but thanks for
splitting as its own patch.

Thanks,
Mark.

> +
> +** SPE Required properties:
> +
> +- compatible : should be one of:
> +	       "arm,statistical-profiling-extension-v1"
> +
> +- interrupts : Exactly 1 PPI must be listed. For heterogeneous systems where
> +               SPE is only supported on a subset of the CPUs, please consult
> +	       the arm,gic-v3 binding for details on describing a PPI partition.
> +
> +** Example:
> +
> +spe-pmu {
> +        compatible = "arm,statistical-profiling-extension-v1";
> +        interrupts = <GIC_PPI 05 IRQ_TYPE_LEVEL_HIGH &part1>;
> +};
> -- 
> 2.1.4
> 
