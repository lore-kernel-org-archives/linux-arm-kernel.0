From: alex.bou9@gmail.com (Alex Bounine)
Date: Tue, 31 Jul 2018 09:15:58 -0400
Subject: [PATCH 5/6] arm: enable RapidIO menu in Kconfig
In-Reply-To: <20180731124815.GK17271@n2100.armlinux.org.uk>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-6-acolin@isi.edu> <20180731120428.GA5696@infradead.org>
 <3784698f-bd9d-6d02-6fa4-2f6057e4c93f@gmail.com>
 <20180731124815.GK17271@n2100.armlinux.org.uk>
Message-ID: <bfc9daa3-6dd6-55ed-6a2b-f12f07fc6021@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-31 08:48 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 08:43:02AM -0400, Alex Bounine wrote:
>> On 2018-07-31 08:04 AM, Christoph Hellwig wrote:
>>> On Mon, Jul 30, 2018 at 06:50:33PM -0400, Alexei Colin wrote:
>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>> index afe350e5e3d9..602a61324890 100644
>>>> --- a/arch/arm/Kconfig
>>>> +++ b/arch/arm/Kconfig
>>>> @@ -1278,6 +1278,8 @@ config PCI_HOST_ITE8152
>>>>   source "drivers/pci/Kconfig"
>>>> +source "drivers/rapidio/Kconfig"
>>>
>>> Please include this from drivers/Kconfig instead of enabling it
>>> for a completely random set of architectures.
>>>
>> This is not a random set of architectures but only ones that implement
>> support for RapidIO as system bus.
>>
>> On some platforms RapidIO can be the only system bus available replacing
>> PCI/PCIe.
>>
>> As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or "Bus
>> Support" (ARMs) sub-menu and from system configuration option it should be
>> kept this way.
>>
>> Current location of RAPIDIO configuration option is familiar to users of
>> PowerPC and x86 platforms, and is similarly available in some ARM
>> manufacturers kernel code trees.
> 
> ... which is why you have a HAS_RAPIDIO thing and select it from
> arch/*/Kconfig as I suggested in my original review of your patch
> set.

Correct, this option will be selected as soon as board that supports it 
is added.

> 
> As I've also said, I'm unable to review what you've sent this time
> around because I don't have all your patches.
> 
I think Alexei will resend full set soon.
