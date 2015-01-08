From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Jan 2015 16:23:13 +0000
Subject: Query: ARM64: Behavior of el1_dbg exception while executing
 el0_dbg
In-Reply-To: <54AE830E.1090000@redhat.com>
References: <54AE830E.1090000@redhat.com>
Message-ID: <20150108162312.GO11583@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 01:15:58PM +0000, Pratyush Anand wrote:
> Hi All,
> 
> I am trying to test following scenario, which seems valid to me. But I 
> am very new to ARM64 as well as to debugging tools, so seeking expert's 
> comment here.
> 
> -- I have inserted a kprobe to the function uprobe_breakpoint_handler 
> which is called from elo_dbg 
> (el0_dbg->do_debug_exception->brk_handler->call_break_hook->uprobe_breakpoint_handler)
> 
> -- kprobe is enabled.
> 
> -- an uprobe is inserted into a test application and enabled.
> 
> So, when uprobe is enabled and test code execution reaches to probe 
> instruction, it executes uprobe breakpoint instruction and el0_dbg 
> exception is raised.
> 
> When control reaches to start of uprobe_breakpoint_handler and it 
> executes first instruction (which has been replaced with a kprobe 
> breakpoint instruction), el1_dbg exception is raised.

Hmm, debug exceptions should be masked at this point so I don't see why
you're taking the second debug exception.

Will
