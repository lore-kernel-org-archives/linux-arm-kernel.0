From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Fri, 27 Aug 2010 04:41:36 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <1282810627.1975.237.camel@laptop>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop> <op.vh0ud3rg7p4s8u@localhost>
	<1282810627.1975.237.camel@laptop>
Message-ID: <op.vh2sfmqt7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010 10:17:07 +0200, Peter Zijlstra <peterz@infradead.org> wrote:
> So why not work on the page allocator to improve its contiguous
> allocation behaviour. If you look at the thing you'll find pageblocks
> and migration types. If you change it so that you pin the migration type
> of one or a number of contiguous pageblocks to say MIGRATE_MOVABLE, so
> that they cannot be used for anything but movable pages you're pretty
> much there.

And that's exactly where I'm headed.  I've created API that seems to be
usable and meat mine and others requirements (not that I'm not saying it
cannot be improved -- I'm always happy to hear comments) and now I'm
starting to concentrate on the reusing of the grabbed memory.  At first
I wasn't sure how this can be managed but thanks to many comments
(including yours, thanks!) I have an idea of how the thing should work
and what I should do from now.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
