From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Thu, 11 Nov 2010 13:06:16 +0100
Subject: [Questions] How to run 'perf top' on ARM to profile kernel
	functions with modules loaded
In-Reply-To: <20101111091733.GA2929@pulham.picochip.com>
References: <AANLkTinwAL8dFsDbd-ZTQEcEziq6jZk82KPzNqMVxnOx@mail.gmail.com>
	<AANLkTim+BAYKWqiJzSQQLc4e_yNkMsNNnEp5u8YgC2Fk@mail.gmail.com>
	<20101111091733.GA2929@pulham.picochip.com>
Message-ID: <1289477176.2084.64.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-11 at 09:17 +0000, Jamie Iles wrote:
> On Thu, Nov 11, 2010 at 03:52:07PM +0800, Ming Lei wrote:
> > 2010/11/11 Ming Lei <tom.leiming@gmail.com>:
> > > Hi,
> > >
> > > 'perf top' can't display any functions when modules are loaded on ARM.
> > 
> > Sorry, should be can't display any kernel functions when modules are loaded
> > on ARM.
> I've noticed this myself and I spent a bit of time looking into it last week 
> but didn't get too far. I did wonder if it was something to do with the map 
> fixups after loading the modules. If you look at the raw events after a perf 
> record with 'perf report -D' then the last module has a size that takes it to 
> 0xFFFFFFFF which overlaps with the rest of the kernel symbols.
> 
> On x86 it looks like the modules are loaded after the kernel image in VM 
> unlike ARM.

Order shouldn't matter, but that overlap is very likely what kills it.
That module size is buggy.
