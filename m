From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 04 Mar 2014 11:39:43 +0100
Subject: [PATCH V2] ARM: dove: dt: revert PMU interrupt controller node
In-Reply-To: <20140304092616.GH16655@lunn.ch>
References: <20140207180836.GE8533@titan.lakedaemon.net>
 <1392667236-19126-1-git-send-email-jason@lakedaemon.net>
 <20140303150215.GI21483@n2100.arm.linux.org.uk>
 <20140303173740.GC16655@lunn.ch>
 <20140303181529.GM21483@n2100.arm.linux.org.uk>
 <20140303222406.GW1872@titan.lakedaemon.net> <20140304092616.GH16655@lunn.ch>
Message-ID: <5315AD6F.1070804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 10:26 AM, Andrew Lunn wrote:
>> I could have sworn this was discussed with this particular patchset, but
>> I'm unable to find the conversation in my archives.  Neither during the
>> patch submission process, nor the (long) pull request thread.
>>
>> Perhaps it was an irc conversation?  Andrew, Sebastian, can you find a
>> link?  iirc, one of the DT maintainers (Mark Rutland?) raised the same
>> concern and I thought we answered that sufficiently...
>
> It was the cpufreq driver which caused the discussion. I looked at it
> for a while, and then task swapped onto the kirkwood move into
> mach-mvebu.

I guess you are looking for this discussion

http://comments.gmane.org/gmane.linux.power-management.general/41053

and specifically Mark's remarks on PMU and DT in here

http://permalink.gmane.org/gmane.linux.ports.arm.kernel/285384

BTW, +1 for a single PMU node that either serves an mfd (or type
of) driver or that subsystem drivers derive their resources from.
Looking at Dove FS, that would also include clock gating, which
could be a mess to sort out.. anyway, let's get it on.

Sebastian
