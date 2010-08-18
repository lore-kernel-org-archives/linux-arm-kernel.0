From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Tue, 17 Aug 2010 21:05:00 -0400
Subject: [RFC PATCH 01/20] Create generic alignment API (v8)
In-Reply-To: <20100818000056.GA5874@shutemov.name>
References: <20100817231619.277457797@efficios.com>
	<20100817232150.251244768@efficios.com>
	<20100818000056.GA5874@shutemov.name>
Message-ID: <20100818010500.GA2116@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kirill A. Shutemov (kirill at shutemov.name) wrote:
> > Index: linux.trees.git/include/linux/align.h
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux.trees.git/include/linux/align.h	2010-08-17 16:31:50.000000000 -0400
> > @@ -0,0 +1,56 @@
> > +#ifndef _LINUX_ALIGN_H
> > +#define _LINUX_ALIGN_H
> > +
> > +#define __ALIGN_KERNEL(x, a)	__ALIGN_KERNEL_MASK((x), (typeof(x))(a) - 1)
>                                                     ^^^
> Unnecessary braces. And many below.

Good catch, thanks !

I also found some in:

Ring buffer backend
Ring buffer frontend

patches. I fixed them already, they should be OK in the next round.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
