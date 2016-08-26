From: punit.agrawal@arm.com (Punit Agrawal)
Date: Fri, 26 Aug 2016 15:34:05 +0100
Subject: [PATCH v7 1/9] arm64: pmu: add fallback probe table
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
 <1471985280-2243-2-git-send-email-jeremy.linton@arm.com>
Message-ID: <87r39boazm.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

One comment below.

Jeremy Linton <jeremy.linton@arm.com> writes:

> From: Mark Salter <msalter@redhat.com>
>
> In preparation for ACPI support, add a pmu_probe_info table to
> the arm_pmu_device_probe() call. This table gets used when
> probing in the absence of a devicetree node for PMU.
>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---

[...]


> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index e188438..65d8e27 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -147,6 +147,9 @@ struct pmu_probe_info {
>  #define XSCALE_PMU_PROBE(_version, _fn) \
>  	PMU_PROBE(ARM_CPU_IMP_INTEL << 24 | _version, ARM_PMU_XSCALE_MASK, _fn)
>  
> +#define ARMV8_PMU_PART_PROBE(_part, _fn) \
> +	PMU_PROBE((_part) << MIDR_PARTNUM_SHIFT, MIDR_PARTNUM_MASK, _fn)
> +

This hunk could be dropped as it doesn't seem to be used in the
patchset.

With the above change -

FWIW,
        Acked-by: Punit Agrawal <punit.agrawal@arm.com>


>  int arm_pmu_device_probe(struct platform_device *pdev,
>  			 const struct of_device_id *of_table,
>  			 const struct pmu_probe_info *probe_table);
