From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 12 May 2015 09:31:31 +0800
Subject: [PATCH 1/2] ARM64: kernel: make cpu_ops hooks DT agnostic
In-Reply-To: <20150511160401.GC4595@leverpostej>
References: <1431020084-5875-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20150511160401.GC4595@leverpostej>
Message-ID: <555157F3.8040404@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/5/12 0:04, Mark Rutland wrote:
> Hi Lorenzo,
>
>>  /**
>>   * struct cpu_operations - Callback operations for hotplugging CPUs.
>>   *
>> - * @name:	Name of the property as appears in a devicetree cpu node's
>> - *		enable-method property.
>> - * @cpu_init:	Reads any data necessary for a specific enable-method from the
>> - *		devicetree, for a given cpu node and proposed logical id.
>> + * @name:	Name of the enable-method.
> I'm not keen on dropping the DT portion from the name documentation,
> given the name must be the DT enable-method string. I'd prefer to leave
> the original comment, or something at least mentioning that the name is
> a DT enable-method string.
>
> Other than that, this patch looks fine to me, and I don't see issues
> booting on a (DT) system, so:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com> [DT]
>
> Has this has been tested on an ACPI system?

I will test and review this patch set today, thanks.

Hanjun
