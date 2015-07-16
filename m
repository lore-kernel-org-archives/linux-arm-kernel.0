From: majun258@huawei.com (majun (F))
Date: Thu, 16 Jul 2015 16:35:28 +0800
Subject: [PATCH v3 1/3] IRQ/Gic-V3: Add mbigen driver to support mbigen
 interrupt controller
In-Reply-To: <alpine.DEB.2.11.1507081154090.3916@nanos>
References: <1436166548-34920-1-git-send-email-majun258@huawei.com>
 <1436166548-34920-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1507061248090.3916@nanos> <559CA530.2090508@huawei.com>
 <alpine.DEB.2.11.1507081154090.3916@nanos>
Message-ID: <55A76CD0.1050000@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015/7/8 18:44, Thomas Gleixner ??:
> On Wed, 8 Jul 2015, majun (F) wrote:
>> ? 2015/7/6 20:33, Thomas Gleixner ??:
>>> Care to explain what this does? It seems for some nodes you cannot
>>> write the msi message. So how is that supposed to work? How is that
>>> interrupt controlled (mask/unmask ...) ?
>>>
>> This function is used to write irq event id into vector register.Depends on
>> hardware design, write operation is permitted in some mbigen node(nid=0,5,and >7),
>> For other mbigen node, this register is read only.
>>
>> But only vector register has this problem. Other registers are ok for read/write.
> 
> You still fail to explain how that works if the register is not
> writeable. And the code wants a proper comment explaining it.
> 

Actually, the interrupt trigger type, device id and event id already encoded in
mbigen chip.

Depends on hardweare design, the device id and event id value in some mbigen nodes
can't be modified, but some nodes can.

For the mbigen node which event id can't be modified, we can use the default event id
value (encoded in mbigen register).
If the event id can be programmed, we can use this function to modify the event id value.

[....]
> 
> Aside of that, please look at the per-device MSI series Marc posted
> (you were cc'ed). This is going to be where we are heading and your
> driver should be based on that.
Ok, i will  change mbigen code based on Marc's patch.
> 
> Thanks,
> 
> 	tglx
> 
