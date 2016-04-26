From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 26 Apr 2016 14:08:54 -0700
Subject: [PATCH arm 1/1] arm: Use _rcuidle tracepoint to allow use from
 idle
In-Reply-To: <20160426165217.5b46eea7@gandalf.local.home>
References: <20160426190755.GK3715@linux.vnet.ibm.com>
 <20160426193949.GP5995@atomide.com>
 <20160426154414.7bb33de4@gandalf.local.home>
 <20160426195158.GR5995@atomide.com>
 <20160426200613.GO3715@linux.vnet.ibm.com>
 <20160426201134.GA29779@linux.vnet.ibm.com>
 <20160426202538.GS5995@atomide.com>
 <20160426204148.GR3715@linux.vnet.ibm.com>
 <20160426204613.GT5995@atomide.com>
 <20160426165217.5b46eea7@gandalf.local.home>
Message-ID: <20160426210854.GU3715@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 04:52:17PM -0400, Steven Rostedt wrote:
> On Tue, 26 Apr 2016 13:46:15 -0700
> Tony Lindgren <tony@atomide.com> wrote:
> 
> 
> > [ INFO: suspicious RCU usage. ]
> > 4.6.0-rc5-next-20160426+ #1127 Not tainted
> > -------------------------------
> > include/trace/events/clk.h:45 suspicious rcu_dereference_check() usage!
> > 
> > other info that might help us debug this:
> > 
> > 
> > RCU used illegally from idle CPU!
> > rcu_scheduler_active = 1, debug_locks = 0
> > RCU used illegally from extended quiescent state!
> > 2 locks held by swapper/0/0:
> >  #0:  (&oh->hwmod_key#30){......}, at: [<c0121afc>] omap_hwmod_enable+0x18/0x44
> >  #1:  (enable_lock){......}, at: [<c0630684>] clk_enable_lock+0x18/0x124
> > 
> 
> Hah! I knew that mole would show up.

There do seem to be quite a few candidate moles, don't there?

							Thanx, Paul
