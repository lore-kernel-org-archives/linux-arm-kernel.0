From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 11 Sep 2015 15:06:47 +0100
Subject: [PATCH 0/5] ACPI probing infrastructure
In-Reply-To: <55F14753.5070703@linaro.org>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
 <55EEE071.7040506@linaro.org> <55F14753.5070703@linaro.org>
Message-ID: <55F2DFF7.6090301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/15 10:03, Hanjun Guo wrote:
> On 09/08/2015 09:19 PM, Hanjun Guo wrote:
>> Hi Marc,
>>
>> Sorry for the late response for quite a while...
>>
>> On 09/05/2015 01:06 AM, Marc Zyngier wrote:
>>> IRQ controllers and timers are the two types of device the kernel
>>> requires before being able to use the device driver model.
>>>
>>> ACPI so far lacks a proper probing infrastructure similar to the one
>>> we have with DT, where we're able to declare IRQ chips and
>>> clocksources inside the driver code, and let the core code pick it up
>>> and call us back on a match. This leads to all kind of really ugly
>>> hacks all over the arm64 code and even in the ACPI layer.
>>>
>>> It turns out that providing such a probing infrastructure is rather
>>> easy, and provides a much deserved cleanup in both the arch code, the
>>> GIC driver, and the architected timer driver.
>>>
>>> I'm sure there is some more code to be deleted, and one can only
>>> wonder why this wasn't done before the arm64 code was initially merged
>>> (the diffstat says it all...).
>>>
>>> Patches are against v4.2, and a branch is available at
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
>>> acpi/device-probing
> 
> I pulled, and noticed that there is v2, it's cleaner than v1 for the
> patch 1/5 to me :)
> 
>>
>> Great thanks to cleanup these stuff, I will test
>> this patch set and review it, will get back to you
>> if I get anything.
> 
> I tested the v2 and it boots pretty happy as before, if
> you post to maillist,
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

I'm still working on v2, so I'm afraid this is still a bit premature.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
