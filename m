From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Thu, 26 Aug 2010 03:49:00 +0200
Subject: [PATCH/RFCv4 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100825173125.0855a6b0@bike.lwn.net>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<1282310110.2605.976.camel@laptop>
	<20100825155814.25c783c7.akpm@linux-foundation.org>
	<20100825173125.0855a6b0@bike.lwn.net>
Message-ID: <op.vh0vbys97p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Aug 2010 01:31:25 +0200, Jonathan Corbet <corbet@lwn.net> wrote:
> The original OLPC has a camera controller which requires three contiguous,
> image-sized buffers in memory.  That system is a little memory constrained
> (OK, it's desperately short of memory), so, in the past, the chances of
> being able to allocate those buffers anytime some kid decides to start
> taking pictures was poor.  Thus, cafe_ccic.c has an option to snag the
> memory at initialization time and never let go even if you threaten its
> family.  Hell hath no fury like a little kid whose new toy^W educational
> tool stops taking pictures.
>
> That, of course, is not a hugely efficient use of memory on a
> memory-constrained system.  If the VM could reliably satisfy those
> allocation requestss, life would be wonderful.  Seems difficult.  But it
> would be a nicer solution than CMA, which, to a great extent, is really
> just a standardized mechanism for grabbing memory and never letting go.

At this moment it seems nothing more then that but they way I see it
is that with a common, standardised, centrally-managed mechanism for
grabbing memory we can start thinking about the ways to reuse the memory.

If each driver were to grab it's own memory in a way know to itself only
the memory is truly lost but with CMA not only regions can be reused among
devices but also the framework can manage the unallocated memory and try to
utilize it in other ways (movable pages? cache? buffers? some kind of
compressed memory swap?).

What I'm trying to say is that I totally agree with your and other's comments
about CMA essentially grabbing memory and never releasing it but I believe
this can be combat with time when overall idea of haw the CMA API should look
like is agreed upon.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
