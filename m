From: yuanzhichang@hisilicon.com (zhichang.yuan)
Date: Thu, 16 Mar 2017 10:21:58 +0800
Subject: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
 dependency has not met
In-Reply-To: <4600523.rWNiWKrYZC@aspire.rjw.lan>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
 <4600523.rWNiWKrYZC@aspire.rjw.lan>
Message-ID: <58C9F6C6.4090700@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Rafael,

Thanks for your review!

On 2017/3/14 5:24, Rafael J. Wysocki wrote:
> On Monday, March 13, 2017 10:42:41 AM zhichang.yuan wrote:
>> In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue on Asus
>> T100TA), the '_DEP' was supported to solve the dependency of Asus battery. But
>> this patch is specific to Asus battery device.
>> In the real world, there are other devices which need the dependency to play the
>> role on the enumeration order. For example, all the Hip06 LPC
>> periperals(IPMI-BT, uart, etc) must be scanned after the LPC host driver
>> finished the probing. So, it makes sense to add a checking whether the ACPI
>> device meet all the dependencies during its enumeration slot, if not, the
>> enumeration will be delayed till all dependency master finish their work.
>>
>> This patch adds the dependency checking in ACPI enumeration, also the
>> corresponding handling to retrigger the Hip06 LPC peripherals' scanning.
> 
> AFAICS, _DEP is generally abused in the wild and cannot be made generic.  Sorry.
> 

>From the ACPI specification, _DEP is for operation region accesses.
You are right...

How about we add a ACPI handler for our LPC bus?? Just like amba.
In this way, we also can solve the issue about LPC enumeration order.

Thanks,
Zhichang


> Thanks,
> Rafael
> 
> 
> .
> 
