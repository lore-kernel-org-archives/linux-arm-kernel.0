From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 12 May 2012 14:13:07 +0530
Subject: [PATCH 3/7] mmc: dw_mmc: add device tree support
In-Reply-To: <CAOesGMiXfODM=hDp9EP3uQOk041XCvPFfTzDwfkvBWeGWLdCgg@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-4-git-send-email-thomas.abraham@linaro.org>
 <CAOesGMh_0dShqe+kSB1Xgn9bpLv0j+b9QP+vN9N57XHP1geSHg@mail.gmail.com>
 <CAJuYYwSmiPNrFhd9xr2AkAbRfJm_gP9ym+AXyy9jyPG3FnFuhA@mail.gmail.com>
 <CAOesGMiXfODM=hDp9EP3uQOk041XCvPFfTzDwfkvBWeGWLdCgg@mail.gmail.com>
Message-ID: <CAJuYYwTQ6M0uTLQ_1M9HdcBpaYd2vws36Xx0fJFmwfJ-LSVJAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2012 12:37, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Thu, May 10, 2012 at 3:15 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> Hi Olof,
>>
>> On 2 May 2012 23:37, Olof Johansson <olof@lixom.net> wrote:
>>> Hi,
>>
>> [...]
>>
>>>> +# Slots: The slot specific information are contained within child-nodes with
>>>> + ?each child-node representing a supported slot. There should be atleast one
>>>> + ?child node representing a card slot. The name of the slot child node should
>>>> + ?be 'slot{n}' where n is the unique number of the slot connnected to the
>>>> + ?controller. The following are optional properties which can be included in
>>>> + ?the slot child node.
>>>
>>> Since we're talking slots / cards on a bus, I think the addressing
>>> model would be useful here. So in the main controller node:
>>> ? ?#address-cells = <1>;
>>> ? ?#size-cells = <0>;
>>>
>>> And then each slot would need a reg property and possibly unit address:
>>>
>>> ? slot {
>>> ? ? ? ?reg = <0>;
>>> ? ? ? ?...
>>> ? };
>>>
>>> (unit addresses on the slots are only needed if they can't be
>>> disambiguated by name, so not needed if you only have one slot).
>>>
>>
>> Is the addressing model as described above needed in this case? The
>> address for a slot is not used by the controller driver code and is
>> just a virtual number. It would be sufficient to represent the nodes
>> representing the slots with a unique name.
>
> The driver has the concept of slot IDs (slot->id struct member), and
> the hardware definitely enumerates them.
>
> So, I think it makes sense to give a chance to enumerate the slots in
> the device tree. Otherwise, how do you know which one is which on
> hardware? It also opens up the flexibility to have the same name for
> both slots if it makes sense to describe a board that way.

Thanks Olof. Yes, I missed the usage of the id number in the driver. I
will add the slot addressing as you have suggested and repost.

Thanks,
Thomas.

>
>
> -Olof
