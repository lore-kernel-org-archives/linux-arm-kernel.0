From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 26 Nov 2014 00:13:03 +0100
Subject: [PATCH 1/3] ACPI / processor: Update the comments in processor.h
In-Reply-To: <1414662780-2147-1-git-send-email-hanjun.guo@linaro.org>
References: <1414662780-2147-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <2001637.yVyNT03Tcn@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, October 30, 2014 05:52:58 PM Hanjun Guo wrote:
> In commit 46ba51e (ACPI / processor: Introduce ARCH_MIGHT_HAVE_ACPI_PDC),
> acpi_processor_set_pdc() was moved to processor_pdc.c, so update
> the comments accordingly.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Patches [2-3/3] from this set need to be rebased on top of current linux-next
and resent, sorry about that.

> ---
>  include/acpi/processor.h |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 9b9b6f2..cbb6cd3 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -313,11 +313,13 @@ static inline int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
>  #endif				/* CONFIG_CPU_FREQ */
>  
>  /* in processor_core.c */
> -void acpi_processor_set_pdc(acpi_handle handle);
>  int acpi_get_apicid(acpi_handle, int type, u32 acpi_id);
>  int acpi_map_cpuid(int apic_id, u32 acpi_id);
>  int acpi_get_cpuid(acpi_handle, int type, u32 acpi_id);
>  
> +/* in processor_pdc.c */
> +void acpi_processor_set_pdc(acpi_handle handle);
> +
>  /* in processor_throttling.c */
>  int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
>  int acpi_processor_get_throttling_info(struct acpi_processor *pr);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
