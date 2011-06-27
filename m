From: tony@atomide.com (Tony Lindgren)
Date: Mon, 27 Jun 2011 11:16:16 -0700
Subject: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
In-Reply-To: <87hb7bdypb.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin> <4DFF1558.4020509@ti.com>
	<20110620094846.GG23145@atomide.com> <87oc1obnbw.fsf@ti.com>
	<4E035835.50405@ti.com> <20110627080804.GG23145@atomide.com>
	<87hb7bdypb.fsf@ti.com>
Message-ID: <20110627181616.GT23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110627 09:25]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Santosh Shilimkar <santosh.shilimkar@ti.com> [110623 08:09]:
> >> On 6/23/2011 8:35 PM, Kevin Hilman wrote:
> >> >Tony Lindgren<tony@atomide.com>  writes:
> >> >
> >> >So now, the only thing OMAP-specific is the debugfs file used to trigger
> >> >it.
> >> >
> >> >>Maybe Kevin can just carry it along in the PM branch for now?
> >> >
> >> >I'd prefer to keep it in mainline as this is a very important feature
> >> >for the PM functionality already in mainline.
> >> >
> >> I agree with Kevin and that's what have been saying from begining when
> >> we decided to drop this feature. The new patch from Kevin is already
> >> doing this in more generic way than that was before.
> >
> > To me Kevin's later patch makes more sense, but still has few issues:
> >
> > - It keeps the dependency between PM debug code and sys_timer code.
> >   That's yet another artificial blocker for making PM code a loadable
> >   module. We really don't want to export anything from the sys_timer code.
> >
> > - The interface for programming a wake-up timer should be Linux generic,
> >   not omap specific.
> >
> > Further, it's a CONFIG_PM_DEBUG patch. So that code should not be
> > in the mainline kernel.
> 
> Huh?  
> 
> Please clarify why PM debug code shouldn't be in mainline?

Oh sorry I did not mean that. I meant that it's a debug interface so it's
not like we should freeze it. My main issues are the dependencies and
the interface above.

Anyways, I guess you are using this to test suspend on a remote system
with no hardware trigger to wake it back up?

If so, how about some RTC alarm like interface to set the wake-up
event after suspending? There may be a way to do this already and
have it triggered from rtc-omap..

Regards,

Tony
