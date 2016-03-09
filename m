From: julien.grall@arm.com (Julien Grall)
Date: Wed, 9 Mar 2016 13:18:14 +0700
Subject: [PATCH v3 3/9] irqchip/gic-v2: Gather ACPI specific data in a
 single structure
In-Reply-To: <20160309054710.GI26583@lvm>
References: <1457436573-6180-1-git-send-email-julien.grall@arm.com>
 <1457436573-6180-4-git-send-email-julien.grall@arm.com>
 <20160309054710.GI26583@lvm>
Message-ID: <56DFC026.5020909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 09/03/2016 12:47, Christoffer Dall wrote:
> On Tue, Mar 08, 2016 at 11:29:27AM +0000, Julien Grall wrote:
>> For now, there is only one member. More member will be added later.
>
> questionable commit message

What about:

"The ACPI code requires to use global variables in order to collect 
information from the tables.

For now only a single global variable is used, but more will be added in 
a subsequent patch. To make clear they are ACPI specific, gather all the 
information in a single structure."

[...]

>> @@ -1316,7 +1319,7 @@ static int __init gic_v2_acpi_init(struct acpi_subtable_header *header,
>>   		return -EINVAL;
>>   	}
>>
>> -	cpu_base = ioremap(cpu_phy_base, ACPI_GIC_CPU_IF_MEM_SIZE);
>> +	cpu_base = ioremap(acpi_data.cpu_phy_base, ACPI_GIC_CPU_IF_MEM_SIZE);
>>   	if (!cpu_base) {
>>   		pr_err("Unable to map GICC registers\n");
>>   		return -ENOMEM;
>> --
>> 1.9.1
>>
> super nit: I would use cpu_phys_base instead of cpu_phy_base, but I'll
> leave it up to you.

I will update the commit message, so I will rename the variable too.

>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Cheers,

-- 
Julien Grall
