From: zourongrong@huawei.com (Rongrong Zou)
Date: Mon, 4 Jan 2016 18:27:12 +0800
Subject: [PATCH v1 1/3] ARM64 LPC: indirect ISA PORT IO introduced
In-Reply-To: <20160104101124.GA1616@arm.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <1628979.qkJQGmVH0I@wuerfel> <5683A3B4.7040005@huawei.com>
 <23432380.Bk9bdl2Z0r@wuerfel> <20160104101124.GA1616@arm.com>
Message-ID: <568A4900.2030300@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/1/4 18:11, Will Deacon ??:
> On Wed, Dec 30, 2015 at 10:42:50AM +0100, Arnd Bergmann wrote:
>> On Wednesday 30 December 2015 17:28:20 Rongrong Zou wrote:
>>>>>
>>>>
>>>> config ARM64_INDIRECT_PIO
>>>>        bool
>>>>        help
>>>>          Any driver that provides indirect ISA I/O port access should select
>>>>          this symbol
>>>
>>>
>>>>
>>>> config HISILICON_HI123456_LPC
>>>>        bool "Workaround for nonstandard ISA I/O space on Hisilicon Hi123456 SoC"
>>>>        depends on ARCH_HISI || COMPILE_TEST
>>>>        select ARM64_INDIRECT_PIO
>>>>        help
>>>>          ...
>>> Can it be a submenu of "Platform selection--->Hisilicon SoC Family"?
>>
>> The first should be in the main Kconfig file for arm64, the second one depends
>> on where we put the respective code. I'd say both the Kconfig entry and the file
>> can go into drivers/bus, but arch/arm64/kernel/ is also fine with me.
>
> Unsurprisingly, I'd *much* prefer drivers/bus/ !

I'll move it to drivers/bus on next version of patch, thanks!

>
> Will
>
> .
>
