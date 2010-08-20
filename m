From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Fri, 20 Aug 2010 12:54:02 +0200
Subject: [PATCH/RFCv3 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <20100820193328P.fujita.tomonori@lab.ntt.co.jp>
References: <op.vhp4pws27p4s8u@localhost>
	<20100820155617S.fujita.tomonori@lab.ntt.co.jp>
	<op.vhp7rxz77p4s8u@localhost>
	<20100820193328P.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <op.vhqgkcgj7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Aug 2010 12:35:01 +0200, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:

> On Fri, 20 Aug 2010 10:10:45 +0200
> **UNKNOWN CHARSET** <m.nazarewicz@samsung.com> wrote:
>
>> > I wrote "similar to the existing API', not "reuse the existing API".
>>
>> Yes, but I don't really know what you have in mind.  CMA is similar to various
>> APIs in various ways: it's similar to any allocator since it takes
>> size in bytes,
>
> why don't take gfp_t flags?

Because they are insufficient.  Either that or I don't understand gfp_t.

With CMA, platform can define many memory types.  For instance, if there are
two memory bans there can be two memory types for the two banks.  For at least one
of the device I'm in contact with, another type for it's firmware is also needed.
Bottom line is that there may be possibly many types which won't map to gfp_t.

> Something like dev_alloc_page is more appropriate name?

Two things: I'd prefer a "cma" prefix rather then "dev" and I think it should
be "pages", right? Then, size should be given in pages rather then bytes.

Nonetheless, I don't really see at the moment why this should be better.

> Or something similar to dmapool API (mm/dmapool.c) might work
> better. The purpose of dmapool API is creating a pool for consistent
> memory per device. It's similar to yours, creating a pool for
> contiguous memory per device(s)?

I'll try to look at it later on and think about it.  I'm still somehow reluctant
to change the names but still, thank you for suggestions.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
