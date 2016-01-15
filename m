From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Jan 2016 18:08:51 +0000
Subject: [PATCH V12 3/7] dma: add Qualcomm Technologies HIDMA management
 driver
In-Reply-To: <56992FE8.4000606@codeaurora.org>
References: <1452523550-8920-1-git-send-email-okaya@codeaurora.org>
 <1452523550-8920-4-git-send-email-okaya@codeaurora.org>
 <20160115145629.GI3262@leverpostej> <56990CD4.6020405@arm.com>
 <569912F3.9040507@codeaurora.org> <56992C4E.6010606@arm.com>
 <56992FE8.4000606@codeaurora.org>
Message-ID: <569935B3.4090004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/16 17:44, Sinan Kaya wrote:
>>>

[...]

>> You may want to drop the "hypervisor" designation, BTW, because this has
>> no real connection to virtualisation.
>>
> 
> Would you use host/guest relationship?

Not even that. This is a host/user relationship, as VFIO is in no way
virtualisation specific. It just gives you a way to make a device
accessible to userspace. KVM is just a specialised instance of a more
generic problem.

> 
>>>
>>> Once the guest machine is shutdown, VFIO driver still owns the channel device. It can
>>> assign the device to another guest machine.
>>>
>>>> - Does the HYP side requires any context switch (and how is that done)?
>>> No communication is needed.
>>>
>>>> - What makes it safe?
>>> No communication is needed.
>>>
>>>>
>>>> Without any of this information (and pointer to the code to back it up),
>>>> I'm very reluctant to take any of this.
>>>
>>> Please let me know what exactly is not clear. 
>>>
>>> You don't write a virtualization driver for 8139too driver. The driver works whether it is running in the 
>>> guest machine or the hypervisor. 
>>
>> Exactly. No hypervisor code needed whatsoever. So please get rid of this
>> hypervisor nonsense! ;-)
>>
> 
> I need the management driver for administrative purposes and common initialization. 
> I like the split SW design as it follows the HW design too.

I have no problem with the split design (whatever floats your boat),
more with the terminology which I find very confusing. It would be a lot
better if you stuck with management (host) and client (user), or some
other general terminology.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
