From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sat, 12 May 2018 12:10:40 +0200
Subject: [PATCH v9 11/12] ACPI: Add PPTT to injectable table list
In-Reply-To: <20180511235807.30834-12-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-12-jeremy.linton@arm.com>
Message-ID: <CAJZ5v0giM0W6KJtxArLLm90gi136pBoc_dz0H-5wg24b_ih0Yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2018 at 1:58 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Add ACPI_SIG_PPTT to the table so initrd's can override the
> system topology.
>
> Signed-off-by: Geoffrey Blake <geoffrey.blake@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I'm assuming that this will be routed along with the rest of the series, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 849c4fb19b03..30d93bf7c6a2 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -457,7 +457,7 @@ static const char * const table_sigs[] = {
>         ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
>         ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
>         ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
> -       ACPI_SIG_NFIT, ACPI_SIG_HMAT, NULL };
> +       ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT, NULL };
>
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
