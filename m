From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 17 Jul 2014 11:18:06 +0800
Subject: [PATCH v2 1/3] ACPI: ARM64 does not have a BIOS add config for
 BIOS table scan.
In-Reply-To: <53C70F78.40206@zytor.com>
References: <1404898746-6685-1-git-send-email-hanjun.guo@linaro.org>
 <1404898746-6685-2-git-send-email-hanjun.guo@linaro.org>
 <53C70CCC.2080109@zytor.com>
 <3908561D78D1C84285E8C5FCA982C28F3285FB3C@ORSMSX114.amr.corp.intel.com>
 <53C70F78.40206@zytor.com>
Message-ID: <53C7406E.40902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-7-17 7:49, H. Peter Anvin wrote:
> On 07/16/2014 04:46 PM, Luck, Tony wrote:
>>> +	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
>>
>>> This shouldn't actually be set on IA64, should it?  IA64 doesn't have
>>> BIOS, either, it has EFI/UEFI, like ARM64...

Yes, I agree with you, thanks for pointing this out. if I remember
correctly, the EFI standard was introduced when IA64 came out.

>>
>> Which ACPI tables are in the "LEGACY" category affected by this option?
>>
> 
> That's not what this is about... it is about how you find the root pointer.
> 
> On a BIOS system it is found by scanning low memory.  On an EFI system
> it is found by querying EFI for a specific UUID.

Thanks for the explanation.

Tony, if it is ok with you, I will modify the patch and will not select
ACPI_LEGACY_TABLES_LOOKUP on IA64, I'm waiting for your final confirmation.

Thanks
Hanjun
