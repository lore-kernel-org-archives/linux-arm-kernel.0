From: robh@kernel.org (Rob Herring)
Date: Thu, 27 Jul 2017 10:52:37 -0500
Subject: [PATCH v3 5/6] dt-bindings: Document devicetree binding for ARM
 DSU PMU
In-Reply-To: <1501168218-26741-6-git-send-email-suzuki.poulose@arm.com>
References: <1501168218-26741-1-git-send-email-suzuki.poulose@arm.com>
 <1501168218-26741-6-git-send-email-suzuki.poulose@arm.com>
Message-ID: <CAL_JsqLkeaMh8afWvYwca61OrX7QYzDt+eup_b3rQuyxumLwfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+DT list

On Thu, Jul 27, 2017 at 10:10 AM, Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
> This patch documents the devicetree bindings for ARM DSU PMU.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/arm-dsu-pmu.txt        | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
> new file mode 100644
> index 0000000..b9935ac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
> @@ -0,0 +1,27 @@
> +* ARM DynamIQ Shared Unit (DSU) Performance Monitor Unit (PMU)
> +
> +ARM DyanmIQ Shared Unit (DSU) integrates one or more CPU cores
> +with a shared L3 memory system, control logic and external interfaces to
> +form a multicore cluster. The PMU enables to gather various statistics on
> +the operations of the DSU. The PMU provides independent 32bit counters that
> +can count any of the supported events, along with a 64bit cycle counter.
> +The PMU is accessed via CPU system registers and has no MMIO component.
> +
> +** DSU PMU required properties:
> +
> +- compatible   : should be one of :
> +
> +               "arm,dsu-pmu"

Seems kind of generic. There's only one flavor is DSU?

> +
> +- interrupts   : Exactly 1 SPI must be listed.
> +
> +- cpus         : List of phandles for the CPUs connected to this DSU instance.
> +
> +
> +** Example:
> +
> +dsu_pmu at 0 {

Don't use "_" in node names and unit-address is not valid without a
reg property.

> +       compatible = "arm,dsu-pmu";
> +       interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>;
> +       cpus = <&cpu_0>, <&cpu_1>;
> +};
> --
> 2.7.5
>
