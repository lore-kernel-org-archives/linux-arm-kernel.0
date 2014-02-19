From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Wed, 19 Feb 2014 16:32:34 +0000
Subject: [Linaro-acpi] [PATCH v4 5/5] ACPI: Replace printk with pr_* in
 tables.c
In-Reply-To: <1392731700-10992-6-git-send-email-hanjun.guo@linaro.org>
References: <1392731700-10992-1-git-send-email-hanjun.guo@linaro.org>
 <1392731700-10992-6-git-send-email-hanjun.guo@linaro.org>
Message-ID: <5304DCA2.5080906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/02/14 13:55, Hanjun Guo wrote:
> This patch just do some clean up to replace printk with pr_*,
> no functional change.
> 
Any particular reason for choosing just this file in this series ?
It seems but off-topic in this series. The printk format is same in almost all
other acpi files and it's better to change all or none for consistency.

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/tables.c |   51 +++++++++++++++++++------------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 5837f85..97bc6df 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -55,8 +55,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		{
>  			struct acpi_madt_local_apic *p =
>  			    (struct acpi_madt_local_apic *)header;
> -			printk(KERN_INFO PREFIX
> -			       "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> +			pr_info(PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",

You can even get rid of PREFIX by defining pr_fmt instead.

If the intention is to move to pr_* format it's better to have this as separate
patch and convert all of them. Based on the grep patterns, regex should to
helpful to find and replace them all :)

Regards,
Sudeep
