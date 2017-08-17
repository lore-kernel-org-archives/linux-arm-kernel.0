From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 17 Aug 2017 10:12:22 +0100
Subject: [PATCHv2 0/3] arm64 xilinx zynqmp firmware interface
In-Reply-To: <0560c79f-e461-6010-0628-e99ce0a1f8c6@xilinx.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
 <43deeed7-32c8-7914-5f44-862ebbe14a3b@arm.com>
 <89e5469b-650e-64c7-1754-797b35bac523@xilinx.com>
 <a1970cb5-1cf1-d38a-3de3-c782c23fc8ac@arm.com>
 <0560c79f-e461-6010-0628-e99ce0a1f8c6@xilinx.com>
Message-ID: <45e58860-cb8c-75f2-60bf-140aa3704169@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/08/17 09:42, Michal Simek wrote:
> On 17.8.2017 09:52, Marc Zyngier wrote:
>> On 17/08/17 07:10, Michal Simek wrote:
>>> On 16.8.2017 17:39, Marc Zyngier wrote:
>>>> On 16/08/17 13:24, Michal Simek wrote:
>>>>> Hi,
>>>>>
>>>>> xilinx is using this interface for very long time and we can't merge our
>>>>> driver changes to Linux because of missing communication layer with
>>>>> firmware. This interface was developed before scpi and scmi was
>>>>> available. In connection to power management scpi and scmi are missing
>>>>> pieces which we already use. There is a separate discussion how to
>>>>> extend scmi to support all our use cases.
>>>>
>>>> So maybe we should wait and see where this discussion is going before we
>>>> merge yet another firmware interface?
>>>
>>> It will take a lot of time when this discussion ends and I can't see any
>>> benefit to hold all
>>
>> Well, so far, the benefit of this series is exactly nil, as the code it
>> brings is *unused*. It is impossible to review in isolation.
>>
> 
> Ok. I will add others drivers to this series that's not a problem.
> 
>> In the meantime, you can continue finding out how *not* to have to merge
>> this code, and instead focus on using the infrastructure we already
>> have, or at least influence the infrastructure that is being designed.
>> It will be much better than dumping yet another slab of "I'm so
>> different" code that is going to ultimately bitrot.
> 
> I am happy to look the better proposed way. SCPI is ancient and SCMI is
> replacement and not merged yet. We already had a call with arm and
> Sudeep was on it too where outcome from that was that we can't use that
> because it doesn't support what we need to support now.
> 

OK, none of the specifics were discussed in the meeting to conclude that
SCMI can't be used. My takeaway from the meeting was Xilinx has this
interface for long and being deployed in various systems. I would like
to get into specifics before discarding SCMI as unusable. What bothers
me more is that why was that not raised during the specification review
which was quite a long period IMO ? I tend to think Xilinx never
bothered to look/review the specification as this f/w interface was
already there.

However I still can't see why this was posted once we started pushing
out SCMI patches especially given that this f/w interface was there for
long and no attempts were made in past to upstream this.

Also I am not dismissing the series yet, but if I find that SCMI can be
used(after getting specifics from this series myself), I will at-least
argue against the "SCMI can't be used" argument.

-- 
Regards,
Sudeep
