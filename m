From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 16 Sep 2015 13:00:53 -0400
Subject: [PATCH] arm: add cpu_idle tracepoints to arch_cpu_idle
In-Reply-To: <20150916124128.57b69839@gandalf.local.home>
References: <1442414220-7204-1-git-send-email-jszhang@marvell.com>
 <20150916162817.GC21084@n2100.arm.linux.org.uk>
 <20150916124128.57b69839@gandalf.local.home>
Message-ID: <20150916130053.7a1a7f62@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015 12:41:28 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> [ Added Arjan, as he knows powertop better, as well as
>  Thomas Renninger, that added the cpu_idle trace event ]
> 
> On Wed, 16 Sep 2015 17:28:18 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Wed, Sep 16, 2015 at 10:37:00PM +0800, Jisheng Zhang wrote:
> > > Currently, if cpuidle is disabled or not supported, powertop reports
> > > zero wakeups and zero events. This is due to the cpu_idle tracepoints
> > > are missing.
> > > 
> > > This patch is to make cpu_idle tracepoints always available even if
> > > cpuidle is disabled or not supported.
> > 
> > This seems like a hack to me.  These are cpu_idle tracepoints which
> > tell people when something happens in cpuidle.  If cpuidle is disabled,
> > then surely the tracepoints shouldn't fire.
> > 
> > However, I'll leave it to the tracing people to have the final word on
> > whether this is the right thing to do as I've very little experience
> > with the tracing design.
> 
> Adding back the change log for the original patch:

Bah, it was in the original email. I accidentally double clicked on the
reply part, and claws-mail collapsed it. I never read the change log
via this email because of that.

Sorry Russell, my mistake :-/

-- Steve


> 
> "Currently, if cpuidle is disabled or not supported, powertop reports
> zero wakeups and zero events. This is due to the cpu_idle tracepoints
> are missing.
> 
> This patch is to make cpu_idle tracepoints always available even if
> cpuidle is disabled or not supported."
> 
> This is the same code that sits in x86. I'm assuming it is fine. But
> I'm not an expert on the cpu_idle trace event.
