From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Thu, 26 Aug 2010 03:28:41 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <1282310110.2605.976.camel@laptop>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
Message-ID: <op.vh0ud3rg7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Aug 2010 15:15:10 +0200, Peter Zijlstra <peterz@infradead.org> wrote:
> So the idea is to grab a large chunk of memory at boot time and then
> later allow some device to use it?
>
> I'd much rather we'd improve the regular page allocator to be smarter
> about this. We recently added a lot of smarts to it like memory
> compaction, which allows large gobs of contiguous memory to be freed for
> things like huge pages.
>
> If you want guarantees you can free stuff, why not add constraints to
> the page allocation type and only allow MIGRATE_MOVABLE pages inside a
> certain region, those pages are easily freed/moved aside to satisfy
> large contiguous allocations.

I'm aware that grabbing a large chunk at boot time is a bit of waste of
space and because of it I'm hoping to came up with a way of reusing the
space when it's not used by CMA-aware devices.  My current idea was to
use it for easily discardable data (page cache?).

> Also, please remove --chain-reply-to from your git config. You're using
> 1.7 which should do the right thing (--no-chain-reply-to) by default.

OK.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
