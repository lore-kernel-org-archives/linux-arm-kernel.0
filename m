From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 3 May 2011 01:27:01 +0200
Subject: [RFC PATCH] arm: move timer init to late_timer_init
In-Reply-To: <20110502232815.GI28001@n2100.arm.linux.org.uk>
References: <1304368940-19340-1-git-send-email-plagnioj@jcrosoft.com>
	<20110502222211.GA28001@n2100.arm.linux.org.uk>
	<20110502221522.GG13724@game.jcrosoft.org>
	<20110502231919.GH28001@n2100.arm.linux.org.uk>
	<20110502231714.GE32605@game.jcrosoft.org>
	<20110502232815.GI28001@n2100.arm.linux.org.uk>
Message-ID: <20110502232701.GA2802@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 00:28 Tue 03 May     , Russell King - ARM Linux wrote:
> On Tue, May 03, 2011 at 01:17:14AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 00:19 Tue 03 May     , Russell King - ARM Linux wrote:
> > > On Tue, May 03, 2011 at 12:15:22AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > On 23:22 Mon 02 May     , Russell King - ARM Linux wrote:
> > > > > On Mon, May 02, 2011 at 10:42:20PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > > and add global early device init
> > > > > > this will init earlytimer and will try to probe 1 or 2 timers for clockevents
> > > > > > and clocksource
> > > > > 
> > > > > Why should this change the positioning of sched_clock initialization
> > > > > too?
> > > > > 
> > > > > You know, to spend time sorting out the sched_clock crap that platform
> > > > > people came up with, to get sched_clock working at the right point in
> > > > > the init sequence so that everything is happy, and then to have all
> > > > > that work undone one kernel version later... well, why did I even bother.
> > > > so is it ok to put the early init in time_init for you?
> > > 
> > > If it works there, then there's no problem.  I'm just left wondering why
> > > you decided to try the late_time_init() thing in the first place.  Was
> > > there a specific reason?
> >
> > sh-mobile and sh use it this way
> 
> Do we know why they do?
Magnus or Paul will answer better than me
IIRC on sh it's was because the timer init the IRQ too early

but on sh-mobile not sure

I test it on at91 with pit and st timers and I get no issue

Best Regards,
J.
