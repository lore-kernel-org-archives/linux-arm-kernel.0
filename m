From: rostedt@goodmis.org (Steven Rostedt)
Date: Fri, 03 Feb 2012 15:02:55 -0500
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <20120203194005.GK2382@linux.vnet.ibm.com>
References: <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com>
 <1328223819.5882.133.camel@gandalf.stny.rr.com>
 <20120202232736.GL2518@linux.vnet.ibm.com>
 <1328237131.5882.135.camel@gandalf.stny.rr.com>
 <20120203060458.GF2380@linux.vnet.ibm.com>
 <1328295309.5882.178.camel@gandalf.stny.rr.com>
 <20120203194005.GK2382@linux.vnet.ibm.com>
Message-ID: <1328299375.5882.204.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-03 at 11:40 -0800, Paul E. McKenney wrote:

> So the idea is that if you have a trace event that is to be used in idle,
> you use TRACE_EVENT_IDLE() rather than TRACE_EVENT() to declare that
> trace event?  That would work for me, and might make for fewer changes
> for the architecture guys.  Also, this should address the code-size
> concerns we discussed yesterday.
> 
> So sounds good!
> 
> Is a DEFINE_EVENT_IDLE() also needed?  Or prehaps a
> DECLARE_EVENT_CLASS_IDLE()?  My guess is "yes" for at least one of the
> two based on include/trace/events/power.h.

I'll have to take a look. I may even find a better way to do this too.

> 
> I will keep RCU_NONIDLE() for at least a little while (reworking comments
> to point out TRACE_EVENT_IDLE() and friends) in case there turn out to
> be non-tracepoint uses of RCU in the idle loop.

OK, I'll take a crack at this next Monday.

-- Steve
