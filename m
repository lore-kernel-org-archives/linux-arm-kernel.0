From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 3 Aug 2015 17:26:05 +0800
Subject: [PATCH 0/2] drivers: PL061: Add platform driver probing support
In-Reply-To: <20150803075848.GH7557@n2100.arm.linux.org.uk>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
 <20150803075848.GH7557@n2100.arm.linux.org.uk>
Message-ID: <55BF33AD.5040502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 2015/8/3 15:58, Russell King - ARM Linux wrote:
> On Mon, Aug 03, 2015 at 02:59:56PM +0800, Shannon Zhao wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> According to ACPI SPEC, it supports ARM boards to use "GPIO-signaled
>> ACPI Events". These events can be used for input events. And to QEMU, it
>> uses GPIO PL061 controller for input events.
>>
>> These two patches add platform driver support for PL061 probed by DT or
>> ACPI.
> 
> This certainly is incorrect for DT, and is probably wrong for ACPI too.
> DT creates amba devices, so binds via the amba device driver.
> 

Oh, sorry. The changes for DT are not necessary. But for ACPI I think it
needs to convert pl061 to platform device since ACPI doesn't support
AMBA devices. The Pl011 also does the same thing to support ACPI
probing. See drivers/tty/serial/amba-pl011.c

Thanks,
-- 
Shannon
