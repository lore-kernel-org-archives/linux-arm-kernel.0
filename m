From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 17 Aug 2017 13:24:40 +0200
Subject: [PATCHv2 0/3] arm64 xilinx zynqmp firmware interface
In-Reply-To: <8123bd03-2822-d2c3-e07f-cc99238d3cbe@arm.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
 <43deeed7-32c8-7914-5f44-862ebbe14a3b@arm.com>
 <89e5469b-650e-64c7-1754-797b35bac523@xilinx.com>
 <a1970cb5-1cf1-d38a-3de3-c782c23fc8ac@arm.com>
 <0560c79f-e461-6010-0628-e99ce0a1f8c6@xilinx.com>
 <45e58860-cb8c-75f2-60bf-140aa3704169@arm.com>
 <07473fe2-d159-a016-2f65-735b1231beb8@xilinx.com>
 <8123bd03-2822-d2c3-e07f-cc99238d3cbe@arm.com>
Message-ID: <1a1de814-d47c-ffd7-ae57-9e5c76122904@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.8.2017 13:18, Sudeep Holla wrote:
> 
> 
> On 17/08/17 11:32, Michal Simek wrote:
>> On 17.8.2017 11:12, Sudeep Holla wrote:
>>>
>>>
>>> On 17/08/17 09:42, Michal Simek wrote:
>>>> On 17.8.2017 09:52, Marc Zyngier wrote:
>>>>> On 17/08/17 07:10, Michal Simek wrote:
>>>>>> On 16.8.2017 17:39, Marc Zyngier wrote:
>>>>>>> On 16/08/17 13:24, Michal Simek wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> xilinx is using this interface for very long time and we
>>>>>>>> can't merge our driver changes to Linux because of
>>>>>>>> missing communication layer with firmware. This interface
>>>>>>>> was developed before scpi and scmi was available. In
>>>>>>>> connection to power management scpi and scmi are missing 
>>>>>>>> pieces which we already use. There is a separate
>>>>>>>> discussion how to extend scmi to support all our use
>>>>>>>> cases.
>>>>>>>
>>>>>>> So maybe we should wait and see where this discussion is
>>>>>>> going before we merge yet another firmware interface?
>>>>>>
>>>>>> It will take a lot of time when this discussion ends and I
>>>>>> can't see any benefit to hold all
>>>>>
>>>>> Well, so far, the benefit of this series is exactly nil, as the
>>>>> code it brings is *unused*. It is impossible to review in
>>>>> isolation.
>>>>>
>>>>
>>>> Ok. I will add others drivers to this series that's not a
>>>> problem.
>>>>
>>>>> In the meantime, you can continue finding out how *not* to have
>>>>> to merge this code, and instead focus on using the
>>>>> infrastructure we already have, or at least influence the
>>>>> infrastructure that is being designed. It will be much better
>>>>> than dumping yet another slab of "I'm so different" code that
>>>>> is going to ultimately bitrot.
>>>>
>>>> I am happy to look the better proposed way. SCPI is ancient and
>>>> SCMI is replacement and not merged yet. We already had a call
>>>> with arm and Sudeep was on it too where outcome from that was
>>>> that we can't use that because it doesn't support what we need to
>>>> support now.
>>>>
>>>
>>> OK, none of the specifics were discussed in the meeting to conclude
>>> that SCMI can't be used. My takeaway from the meeting was Xilinx
>>> has this interface for long and being deployed in various systems.
>>> I would like to get into specifics before discarding SCMI as
>>> unusable. What bothers me more is that why was that not raised
>>> during the specification review which was quite a long period IMO ?
>>> I tend to think Xilinx never bothered to look/review the
>>> specification as this f/w interface was already there.
>>
>> Xilinx is using this interface from Aug 2015. I am not aware about
>> any invitation to spec review. And not sure who was there from
>> xilinx.
>>
> 
> Sure, I can understand and that's not a problem but Xilinx was involved.
> 
>>>
>>> However I still can't see why this was posted once we started
>>> pushing out SCMI patches especially given that this f/w interface
>>> was there for long and no attempts were made in past to upstream
>>> this.
>>
>> The reason is simple which is upstream our code which depends on
>> this communication layer. I don't think there is quick path to move
>> to different interface than this one.
>>
> 
> Do you mean "smc" when you refer communication layer ? If so, that's
> fine. You can use "smc" as transport with SCMI if you want,
> specification doesn't prevent that.

yep, just smc or hvc.


>>>
>>> Also I am not dismissing the series yet, but if I find that SCMI
>>> can be used(after getting specifics from this series myself), I
>>> will at-least argue against the "SCMI can't be used" argument.
>>
>> This is not my argument that we can't use SCMI. This is what was my 
>> understanding from that meeting we had. And definitely there is no
>> quick path for us to switch to SCMI and breaks all current existing
>> customers.
>>
> 
> I understand the latter and I mentioned the same earlier, but I disagree
> with the former. That meeting was mostly introduction(and informal IMO)
> and didn't involve anything at the technical level.

Definitely the first one for me.


>> And this interface is just in the same position as current SCPI. It 
>> means you have SCPI already merged and you are adding new one. SCMI 
>> could be maybe also just SCPIv2.
> 
> Agreed, but it was posted as soon as the specification is out and so is
> the SCMI. I am not arguing it as a point, but just mentioning that this
> post was simply bad timing :)

Definitely not purpose just coincidence. SCMI v1 June 26, SCMI v2 Aug 4.

It is quite clear if Xilinx decides to use SCMI that there will be
transition time between what we use for couple of years to new interface.

Thanks,
Michal
