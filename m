From: khilman@ti.com (Kevin Hilman)
Date: Wed, 14 Mar 2012 14:17:54 -0700
Subject: [PATCH 01/12] mfd: twl-core: don't depend on pdata->irq_base/end
In-Reply-To: <4F6108C1.2060004@ti.com> (Benoit Cousson's message of "Wed, 14
 Mar 2012 22:08:17 +0100")
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-2-git-send-email-b-cousson@ti.com>
 <87pqcegapk.fsf@ti.com> <4F6108C1.2060004@ti.com>
Message-ID: <87y5r2evb1.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 3/14/2012 9:59 PM, Kevin Hilman wrote:
>> Benoit Cousson<b-cousson@ti.com>  writes:
>>
>>> From: Felipe Balbi<balbi@ti.com>
>>>
>>> With sparse IRQs the driver shouldn't depend at all on
>>> any IRQ values coming from board-file.
>>>
>>> Remove every occurences of pdata->irq_base/end.
>>
>> Well, not quite *every*. :)
>
> Hehe, good catch, thanks.
>
>> If the driver isn't going to use those fields anymore, they should also
>> be removed from the pdata struct too[1].  Also, the remaining board/init
>> code that is initializing those fields should be removed as well[2], since
>> it obviously has no effect.
>>
>> The first patch below should probably be folded into this one, and then
>> the 2nd patch removes all the users.
>
> We should probably remove all the users before removing the attribute?
> It looks like your patches are ordered in the opposite way.

Agreed.

> I'll add that in the series and repost the pull request.

Great, thanks.

Kevin
