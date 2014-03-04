From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 04 Mar 2014 15:02:25 +0100
Subject: [PATCH V2] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140304135306.GL1872@titan.lakedaemon.net>
References: <20140207180836.GE8533@titan.lakedaemon.net>
 <1392667236-19126-1-git-send-email-jason@lakedaemon.net>
 <20140303150215.GI21483@n2100.arm.linux.org.uk>
 <20140303173740.GC16655@lunn.ch>
 <20140303181529.GM21483@n2100.arm.linux.org.uk>
 <20140303222406.GW1872@titan.lakedaemon.net> <20140304092616.GH16655@lunn.ch>
 <5315AD6F.1070804@gmail.com> <20140304121136.GR21483@n2100.arm.linux.org.uk>
 <20140304135306.GL1872@titan.lakedaemon.net>
Message-ID: <5315DCF1.90608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 02:53 PM, Jason Cooper wrote:
> On Tue, Mar 04, 2014 at 12:11:36PM +0000, Russell King - ARM Linux wrote:
>> On Tue, Mar 04, 2014 at 11:39:43AM +0100, Sebastian Hesselbarth wrote:
>>> On 03/04/2014 10:26 AM, Andrew Lunn wrote:
>>>>> I could have sworn this was discussed with this particular patchset, but
>>>>> I'm unable to find the conversation in my archives.  Neither during the
>>>>> patch submission process, nor the (long) pull request thread.
>>>>>
>>>>> Perhaps it was an irc conversation?  Andrew, Sebastian, can you find a
>>>>> link?  iirc, one of the DT maintainers (Mark Rutland?) raised the same
>>>>> concern and I thought we answered that sufficiently...
>>>>
>>>> It was the cpufreq driver which caused the discussion. I looked at it
>>>> for a while, and then task swapped onto the kirkwood move into
>>>> mach-mvebu.
>>>
>>> I guess you are looking for this discussion
>>>
>>> http://comments.gmane.org/gmane.linux.power-management.general/41053
>>>
>>> and specifically Mark's remarks on PMU and DT in here
>>>
>>> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/285384
>>>
>>> BTW, +1 for a single PMU node that either serves an mfd (or type
>>> of) driver or that subsystem drivers derive their resources from.
>>> Looking at Dove FS, that would also include clock gating, which
>>> could be a mess to sort out.. anyway, let's get it on.
>>
>> So we have cpufreq, pm domains and an irq controller.  What's the plan
>> for this, who's going to look at sorting this out?
>
> Andrew, Sebastian?  I'm currently task-saturated...

Phew, looks like I'll have to take it?

Are you guys ok with having a single PMU node with syscon provided
regmap and make all drivers depend on it? I'd like to get a go from
Russell here, as he has clearly something in mind.

We can consolidate drivers later if required. If we start that now,
we definitely risk running out of time for v3.15.

Sebastian
