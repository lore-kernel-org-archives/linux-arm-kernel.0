From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 3 May 2013 23:26:23 +0200
Subject: [PATCH, RFC 14/22] oprofile: always enable IRQ_WORK
In-Reply-To: <1367594095.7373.14.camel@gandalf.local.home>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <20130503115332.GT8356@rric.localhost>
 <1367594095.7373.14.camel@gandalf.local.home>
Message-ID: <201305032326.23973.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 May 2013, Steven Rostedt wrote:
> On Fri, 2013-05-03 at 13:53 +0200, Robert Richter wrote:
> > On 02.05.13 17:16:18, Arnd Bergmann wrote:
> > > oprofile fails to build if CONFIG_IRQ_WORK is not already enabled,
> > > because of the dependency on the RING_BUFFER code that now uses
> > > the irq work library.
> > > 
> > > kernel/built-in.o: In function `ring_buffer_unlock_commit':
> > > :(.text+0x5b8f0): undefined reference to `irq_work_queue'
> > > kernel/built-in.o: In function `ring_buffer_write':
> > > :(.text+0x5bd10): undefined reference to `irq_work_queue'
> > 
> > Shouldn't this be fixed in the ring_buffer implementation?
> 
> Does this patch fix it?
> 


Yes, this works, and looks much nicer than my version. Thanks!

	Arnd
