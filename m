From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 07 Sep 2015 16:32:05 +0100
Subject: [PATCH v2 1/5] ACPI: add in a bad_madt_entry() function to
 eventually replace the macro
In-Reply-To: <1440022048-6285-2-git-send-email-al.stone@linaro.org>
References: <1440022048-6285-1-git-send-email-al.stone@linaro.org>
 <1440022048-6285-2-git-send-email-al.stone@linaro.org>
Message-ID: <55EDADF5.5060008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Al,

On 19/08/15 23:07, Al Stone wrote:

I finally got a chance to try this series on Juno. Well it exposed a 
firmware bug in MADT table :)

[..]

>                  acpi_tbl_entry_handler handler,
> @@ -245,6 +484,8 @@ acpi_parse_entries(char *id, unsigned long table_size,
>                 table_end) {
>                  if (entry->type == entry_id
>                      && (!max_entries || count < max_entries)) {
> +                       if (bad_madt_entry(table_header, entry))
> +                               return -EINVAL;

Not sure if we can have the above check here unconditionally.
Currently I can see there are 2 other users of acpi_parse_entries i.e.
PCC and NUMA. So may be it can be made conditional or return success for
non-MADT tables from bad_madt_entry ?

Other than that, you can add for ARM64 specific parts:
Reviewed-and-tested-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
