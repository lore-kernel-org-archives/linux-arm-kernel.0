From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 10 Mar 2015 10:35:58 +0800
Subject: [PATCH v9 01/21] ACPI / table: Use pr_debug() instead of pr_info()
 for MADT table scanning
In-Reply-To: <1425673876.12017.50.camel@perches.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>	
 <1424853601-6675-2-git-send-email-hanjun.guo@linaro.org>	
 <20150306201718.9363CC40AA9@trevor.secretlab.ca>
 <1425673876.12017.50.camel@perches.com>
Message-ID: <54FE588E.4030406@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?07? 04:31, Joe Perches wrote:
> On Fri, 2015-03-06 at 20:17 +0000, Grant Likely wrote:
>> On Wed, 25 Feb 2015 16:39:41 +0800 Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>> This patch just use pr_debug() instead of pr_info() for ioapic/iosapic,
>>> local apic/x2apic/sapic structures when scanning the MADT table to remove
>>> those verbose information, but leave other structures unchanged.
> []
>> One nitpick below, but don't respin over this, and don't do a fixup.
> []
>>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> []
>>> @@ -61,9 +63,9 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>>>   		{
>>>   			struct acpi_madt_local_apic *p =
>>>   			    (struct acpi_madt_local_apic *)header;
>>> -			pr_info("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
>>> -				p->processor_id, p->id,
>>> -				(p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>>> +			pr_debug("LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
>>> +				 p->processor_id, p->id,
>>> +				 (p->lapic_flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
>>
>> The whitespace changes makes each 1 line change into 3 line changes. In
>> these situations, I would chose to leave the whitespace alone to keep
>> the diffstat as small as possible. It makes it less likely to conflict
>> with other patches and easier to find context.
>
> I think it's mostly better to use a consistent indentation style
> regardless of the number in whitespace changes surrounding the change.

I think both would be fine. Since this patch only touches acpi core
code and ACPI maintainer Rafael already acked it, I will keep it as
it is.

Thanks
Hanjun
