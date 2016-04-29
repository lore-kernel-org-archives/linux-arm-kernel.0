From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2016 17:37:48 +0200
Subject: [PATCH] sched/core: don't include asm/mmu_context from drivers
In-Reply-To: <20160429094218.61b26849@gandalf.local.home>
References: <1461919995-21001-1-git-send-email-arnd@arndb.de>
 <20160429094218.61b26849@gandalf.local.home>
Message-ID: <4235157.5fsGtDGIFX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2016 09:42:18 Steven Rostedt wrote:
> On Fri, 29 Apr 2016 10:52:32 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > This reverts the earlier fix attempt and works around the problem
> > by including both linux/mmu_context.h and asm/mmu_context.h from
> > kernel/sched/core.c. This is not a good solution but seems less
> > hacky than the alternatives.
> 
> What about simply not compiling finish_arch_post_lock_switch() when
> building modules?
> 
> (untested, not compiled or anything)
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 

It should work as well.

I think I suggested doing that the last time the problem came up
a few years ago, but we ended up not including the header instead,
so I kept doing that.

	Arnd
