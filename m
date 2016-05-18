From: agraf@suse.de (Alexander Graf)
Date: Wed, 18 May 2016 17:33:41 +0200
Subject: [PATCH v2] arm64: Allow for different DMA and CPU bus offsets
In-Reply-To: <20160518151958.GH22378@e104818-lin.cambridge.arm.com>
References: <1463576010-115428-1-git-send-email-agraf@suse.de>
 <20160518132741.GE22378@e104818-lin.cambridge.arm.com>
 <573C72DD.6010400@suse.de> <20160518142620.GA22354@localhost.localdomain>
 <573C7D64.5040206@suse.de>
 <20160518151958.GH22378@e104818-lin.cambridge.arm.com>
Message-ID: <573C8B55.3030805@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2016 05:19 PM, Catalin Marinas wrote:
> On Wed, May 18, 2016 at 04:34:12PM +0200, Alexander Graf wrote:
>> On 05/18/2016 04:26 PM, Catalin Marinas wrote:
>>> On Wed, May 18, 2016 at 03:49:17PM +0200, Alexander Graf wrote:
>>>> On 05/18/2016 03:27 PM, Catalin Marinas wrote:
>>>>> On Wed, May 18, 2016 at 02:53:30PM +0200, Alexander Graf wrote:
>>>>>> On arm64, all SoCs we supported so far either have an IOMMU or have bus
>>>>>> addresses equal to CPU addresses.
>>>>>>
>>>>>> However, with the Raspberry Pi 3 coming up, this is no longer true. To
>>>>>> allow DMA to work with an AArch64 kernel on those devices, let's allow
>>>>>> devices to have DMA offsets again.
>>>>>>
>>>>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>>>> We were aware about this issue but we've been waiting for an actual use
>>>>> case. I'll queue this for 4.8 (given that RPi3 is not supported by the
>>>>> arm64 kernel, I don't see the rush to merge it earlier).
>>>> Sure, works for me. That way Eric can try to push the other few bits
>>>> necessary to run an arm64 kernel on the RPi3 towards 4.8 as well :).
>>> As long as the firmware is PSCI capable ;)
>> So spin tables won't work for you?
> They only work for booting, not cpuidle or hotplug.

Well, booting is a good step forward I'd say :).

>
>> IIRC we don't own EL3 on there.
> Then how do you switch to AArch64?

You write into config.txt that you want to boot into AArch64 EL2 and the 
raspberry pi firmware takes care of the rest.


Alex
