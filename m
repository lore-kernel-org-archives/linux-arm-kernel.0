From: JBeulich@suse.com (Jan Beulich)
Date: Mon, 23 Nov 2015 09:56:10 -0700
Subject: [PATCH v3 23/62] acpi/table: Introduce acpi_parse_entries
In-Reply-To: <1447753261-7552-24-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-24-git-send-email-shannon.zhao@linaro.org>
Message-ID: <5653533A02000078000B800C@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
> From: Parth Dixit <parth.dixit@linaro.org>
> 
> Add new function acpi_parse_entries which takes acpi table as argument.
> This will avoid fetching table everytime in acpi_table_parse_entries.
> This function will be used in acpi_gicv2_init within another patch.
> 
> Signed-off-by: Naresh Bhat <Naresh.Bhat@linaro.org>
> Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Please clarify authorship: From and first S-o-b aren't really in line.

> --- a/xen/drivers/acpi/tables.c
> +++ b/xen/drivers/acpi/tables.c
> @@ -221,29 +221,27 @@ void __init acpi_table_print_madt_entry(struct 
> acpi_subtable_header *header)
>  	}
>  }
>  
> -
>  int __init
> -acpi_table_parse_entries(char *id,
> -			     unsigned long table_size,
> -			     int entry_id,
> -			     acpi_table_entry_handler handler,
> -			     unsigned int max_entries)
> +acpi_parse_entries(char *id,
> +		      unsigned long table_size,
> +		      acpi_table_entry_handler handler,
> +		      struct acpi_table_header *table_header,
> +		      int entry_id,
> +		      unsigned int max_entries)
>  {
> -	struct acpi_table_header *table_header = NULL;

Looks like Linux has gained similar functionality. Can't you simply
pull in one or more Linux commits?

> -	if (!handler)
> +	if ( !handler )

But in any event please don't change the file's coding style.

Jan
