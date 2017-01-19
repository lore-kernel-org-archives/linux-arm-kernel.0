From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 19 Jan 2017 11:51:28 +0800
Subject: [PATCH v13 1/7] arm64: Rename the common MADT parse routine
In-Reply-To: <1484686210-7211-2-git-send-email-jeremy.linton@arm.com>
References: <1484686210-7211-1-git-send-email-jeremy.linton@arm.com>
 <1484686210-7211-2-git-send-email-jeremy.linton@arm.com>
Message-ID: <c9056b99-7a32-3c91-eb8a-5b44a182c140@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On 2017/1/18 4:50, Jeremy Linton wrote:
> The MADT parser in smp.c is now being used to parse
> out NUMA, PMU and ACPI parking protocol information as
> well as the GIC information for which it was originally
> created. Rename it to avoid a misleading name.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/smp.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index cb87234..8ea244c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -517,13 +517,14 @@ static unsigned int cpu_count = 1;
>
>  #ifdef CONFIG_ACPI
>  /*
> - * acpi_map_gic_cpu_interface - parse processor MADT entry
> + * acpi_verify_and_map_madt - parse processor MADT entry
>   *
>   * Carry out sanity checks on MADT processor entry and initialize
> - * cpu_logical_map on success
> + * cpu_logical_map, the ACPI parking protocol, NUMA mapping
> + * and the PMU interrupts on success
>   */
>  static void __init
> -acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
> +acpi_verify_and_map_madt(struct acpi_madt_generic_interrupt *processor)

Nit, MADT is a table includes multi type of table entries, we just
need to map the the processor type, how about updating it to
acpi_verify_and_map_madt_processor()?

Thanks
Hanjun
