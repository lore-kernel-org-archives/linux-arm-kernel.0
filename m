From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 23 Feb 2012 16:31:51 +0000
Subject: [PATCH] ARM: perf: add PMU hotplug notifiery
In-Reply-To: <4F46658B.3030903@codeaurora.org>
References: <CAKHPGBaY1OFiVubic+f1vxxzNeKjmzibxraBg8eNxZnJbhYi+A@mail.gmail.com>
 <4F4661E2.9020405@codeaurora.org> <4F4662AD.6030306@codeaurora.org>
 <20120223160450.GL29450@mudshark.cambridge.arm.com>
 <4F46658B.3030903@codeaurora.org>
Message-ID: <20120223163145.GD20046@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 04:12:59PM +0000, Ashwin Chaugule wrote:
> On 2/23/2012 11:04 AM, Will Deacon wrote:
> > 
> > Ok. Note that the perf core will actually destroy perf events on a hotplug
> > down notification, so profiling runs will be dead on that core even if it
> > comes back up.
> > 
> > This patch just ensures that we have a sane state in the control registers
> > given that their state is UNKNOWN out of reset. Adding full hotplug support
> > to perf (that is, supporting hotplug events during a run and representing
> > that in a meaningful way) is a larger issue.
> > 
> >>> I'll send a link to my code once the git server is up. It's a bit flaky today.
> > 
> > Ok, cool. Are you happy with me to proceed with the current code for the
> > time being?
> > 
> 
> Sure. We'll need to be able to distinguish between a hotplug and a CPU
> power-collapse / deep sleep / what-have-you state in this code at some
> point since they all have a different effect on the PMU regs.

I have a patch to save/restore PMU regs from idle, I will send it to
Will for review soon so that he can merge the bits that you both deem
worthwhile.

save/restore will be called from CPU PM notifiers on deep-sleep
entry/exit, it is up to the idle state enter function to trigger them when PMU
state is lost.

Thanks,
Lorenzo
