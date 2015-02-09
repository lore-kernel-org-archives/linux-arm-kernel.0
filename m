From: joshc@ni.com (Josh Cartwright)
Date: Mon, 9 Feb 2015 13:18:59 -0600
Subject: [PATCH] clocksource: mark sched_clock_read functions notrace
In-Reply-To: <20150206213103.GB15156@nathan3500-linux-VM>
References: <1422643216-26673-1-git-send-email-nathan.sullivan@ni.com>
 <20150203201326.GH11832@jcartwri.amer.corp.natinst.com>
 <20150206213103.GB15156@nathan3500-linux-VM>
Message-ID: <20150209191859.GC8466@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 03:31:03PM -0600, Nathan Sullivan wrote:
> On Tue, Feb 03, 2015 at 02:13:26PM -0600, Josh Cartwright wrote:
> > > diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> > > index 095c177..df5af55 100644
> > > --- a/drivers/clocksource/arm_arch_timer.c
> > > +++ b/drivers/clocksource/arm_arch_timer.c
> > > @@ -405,7 +405,7 @@ u32 arch_timer_get_rate(void)
> > >  	return arch_timer_rate;
> > >  }
> > >  
> > > -static u64 arch_counter_get_cntvct_mem(void)
> > > +static u64 notrace arch_counter_get_cntvct_mem(void)
> > 
> > Assuming you're trying to mark all sched_clock() implementations
> > notrace, then you missed a few: arch_counter_get_cntvct and
> > arch_counter_get_cntpct.
> > 
> >   Josh
> 
> Hmm, those are inlined.  Should I still mark them notrace?

There's necessarily an out-of-line version of these functions generated,
as arch_timer_read_counter has to point at something, so yes, I'd say
so.

  Josh
