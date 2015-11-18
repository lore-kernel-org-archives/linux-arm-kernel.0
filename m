From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 18 Nov 2015 12:18:39 +0000
Subject: [PATCH v3 00/62] Add ACPI support for arm64 on Xen
In-Reply-To: <564C30B8.3050408@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <564B1508.3060703@citrix.com> <564C30B8.3050408@huawei.com>
Message-ID: <564C6C9F.7020707@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/15 08:03, Shannon Zhao wrote:
> On 2015/11/17 19:52, Julien Grall wrote:
>> Hi Shannon,
>>
>> On 17/11/15 09:39, shannon.zhao at linaro.org wrote:
>>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>>
>>> This patch set adds ACPI support for arm64 on Xen. The design document
>>> could be found from [1].
>>
>> Thank you for your work on it. I think this series would benefits to be
>> split in smaller series.
>>
>> I would do a first series which split DT code from common code. So we
>> can get this code as soon as possible in Xen, avoid you to spend less
>> time rebasing your us to be spammed with 62 patches for each new version.
>>
> 
> Sure, I think I can split this patch set in three parts.
> 
> First one would be porting the necessary Linux changes of ACPI 5.0~6.0.
> It includes:
> 
> ACPI 5.0: Add new/changed tables to headers (only changes of Generic
> Interrupt and Generic Distributor and some changes already exist)
> ACPICA/ARM: ACPI 5.1: Update for MADT changes.
> ACPICA: ACPI 6.0: Add changes for MADT table.
> ACPICA: ACPI 6.0: Add values for MADT GIC version field
> ACPICA/ARM: ACPI 5.1: Update for FADT changes.
> ACPICA: ACPI 6.0: Add changes for FADT table
> ACPICA/ARM: ACPI 5.1: Update for GTDT table changes.
> ACPICA: Headers: Add GTDT flag definitions for the timer subtable.
> ACPICA: ACPI 6.0: Add support for STAO table
> 
> Second one as you suggest would be the series which split DT codes from
> common code.
> 
> And the last one would be the series which add ACPI support for Xen on
> ARM and prepare the necessary things for Dom0.
> 
> How about this way? The order of the first and second can be changed if
> you like.

I'm fine with either way.

Regards,

-- 
Julien Grall
