From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 17 Apr 2014 16:49:33 -0400
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <alpine.LFD.2.11.1404171543350.980@knanqh.ubzr>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <alpine.LFD.2.11.1404171543350.980@knanqh.ubzr>
Message-ID: <53503E5D.8000301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 03:48 PM, Nicolas Pitre wrote:
> On Thu, 17 Apr 2014, Christopher Covington wrote:
> 
>> On 04/16/2014 07:21 PM, Nicolas Pitre wrote:
>>> On Wed, 16 Apr 2014, Christopher Covington wrote:
>>
>>>> Thank you for the suggestion. This approach also came to mind, but it would
>>>> require new documentation and tooling in the JTAG scripts or simulator
>>>> equivalent. That's another aspect of the ELF-based approaches that I
>>>> like--hopefully existing documentation and tool support could be reused.
>>>
>>> The above is useful for loading the raw uncompressed Image without 
>>> carrying the full ELF baggage.
>>
>> What exactly is the full ELF baggage? Aren't there existing mechanisms to omit
>> debugging symbols, for example, if size is of concern?
> 
> Most existing bootloaders don't have the ability to parse ELF files.  
> This is therefore not the typical kernel image format.  The uncompressed 
> kernel image is not very typical either, but like zImage it doesn't rely 
> on any parser in the bootloader.

It's not obvious to me how you reached that conclusion.

http://en.wikipedia.org/wiki/Comparison_of_boot_loaders#Technical_information

(It looks like syslinux now supports ELF as well:
http://git.kernel.org/cgit/boot/syslinux/syslinux.git/plain/com32/modules/elf.c?id=HEAD)

In any case, when performing boot debugging I'm not as interested in
traditional self-hosted bootloaders as I am external loaders, like those built
into software models (QEMU, Fast Models, etc.) or available to JTAG scripts
(OpenOCD, Trace32, etc.). These seem to generally have ELF support.

I'll play around with Jason's patch (thanks!) and see how things look in practice.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
