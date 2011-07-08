From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 07 Jul 2011 17:55:51 -0700
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <20110707223620.GG20403@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
	<4E15ECB6.40100@codeaurora.org>
	<20110707223620.GG20403@n2100.arm.linux.org.uk>
Message-ID: <4E165597.90002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2011 03:36 PM, Russell King - ARM Linux wrote:
> On Thu, Jul 07, 2011 at 10:28:22AM -0700, Stephen Boyd wrote:
>> On 07/06/2011 03:22 AM, Russell King - ARM Linux wrote:
>>> The following series of patches are targetted at two issues:
>>>
>>> 1. Fixing large initramfs causing PC24 relocations to become out of
>>>    range.  This fixes both modules and link-time errors.
>>>
>>> 2. Making the vmlinux easier to pinpoint the various section-built
>>>    data structures and inspect them later.
>>>
>>> For the main kernel, this allows the size of various sections to be
>>> determined via objdump -h.  This also aids objdump -d and -s usage
>>> when asking it to target a particular section.
>>>
>>> For the decompressor, it means that it is now trivially possible to copy
>>> out the compressed kernel vmlinux image by:
>>>
>>>   arm-linux-objcopy -O binary -j .piggydata arch/arm/boot/compressed/vmlinux \
>>> 	piggy.gz
>>>
>>> and thereby obtain the binary kernel image (the Image file) which was
>>> originally used.
>>
>> I gave this series a test with my poison initmem patch and all looks well
>>
>> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>>
>> except for patch 2 as I didn't use a zImage.
>
> Oh, what did you use instead?  I thought no one used the Image files
> anymore...

I used an Image. Android bootloaders are perfectly fine booting those.
Plus, the zreladdr for every MSM post 7x00a isn't upstream.

Which reminds me, the zreladdr for every MSM besides 7x00a and 8x50 is
0xX0208000 which doesn't play nicely with AUTO_ZRELADDR. I wish we could
fix that.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
