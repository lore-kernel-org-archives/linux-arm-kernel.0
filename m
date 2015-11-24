From: JBeulich@suse.com (Jan Beulich)
Date: Tue, 24 Nov 2015 00:22:24 -0700
Subject: [PATCH v3 25/62] acpi/table: Introduce acpi_get_entry to
 get specified entry
In-Reply-To: <5653D4A7.2090204@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-26-git-send-email-shannon.zhao@linaro.org>
 <5653541E02000078000B8079@prv-mh.provo.novell.com>
 <5653D4A7.2090204@huawei.com>
Message-ID: <56541E4002000078000B8304@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 24.11.15 at 04:08, <zhaoshenglong@huawei.com> wrote:
> On 2015/11/24 0:59, Jan Beulich wrote:
>>>>> On 17.11.15 at 10:40, <shannon.zhao@linaro.org> wrote:
>>> +	if ( !table_header )
>>> +	{
>>> +		printk("Table header not present\n");
>>> +		return NULL;
>>> +	}
>>> +
>>> +	table_end = (unsigned long)table_header + table_header->length;
>> 
>> So here you use ->length, ...
>> 
>>> +	/* Parse all entries looking for a match. */
>>> +	entry = (struct acpi_subtable_header *)
>>> +	    ((unsigned long)table_header + table_size);
>> 
>> ... but here table_size. Why?
>> 
> Here it just skips the main table size at the beginning. Then it could
> point to the start of sub-table.
> For example, to MADT table, the table_size is sizeof(struct
> acpi_table_madt).

Well, but for one then the parameter name is kind of wrong, and
second - is it really reasonable for the caller to tell the function?

Jan
