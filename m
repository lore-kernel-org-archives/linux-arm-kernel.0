From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Thu, 10 Dec 2015 10:11:01 -0600
Subject: [PATCH v6 4/4] gicv2m: acpi: Introducing GICv2m ACPI support
In-Reply-To: <56694272.5050706@arm.com>
References: <1449689074-30609-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449689074-30609-5-git-send-email-Suravee.Suthikulpanit@amd.com>
 <56694272.5050706@arm.com>
Message-ID: <5669A415.60300@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/2015 3:14 AM, Marc Zyngier wrote:
>> +int __init gicv2m_init(struct fwnode_handle *parent_handle,
>> >+		       struct irq_domain *parent)
>> >+{
>> >+	int ret = gicv2m_of_init(parent_handle, parent);
>> >+
>> >+	if (ret)
>> >+		ret = gicv2m_acpi_init(parent);
>> >+	return ret;
> This should really read:
>
> 	if (is_of_node(parent_handle))
> 		return gicv2m_of_init(parent_handle, parent);
> 	
> 	return gicv2m_acpi_init(parent);
>
> and you can loose the test for NULL in gicv2m_of_init().
>

Right... Your style of returning which is cleaner ;)

I'll update in V7 and send it out shortly.

Thanks,
Suravee
