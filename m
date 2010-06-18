From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 18 Jun 2010 13:15:52 +0100
Subject: [PATCH 1/5] [ARM] implement arch_randomize_brk()
In-Reply-To: <4C1B50AA.9050507@ru.mvista.com>
Message-ID: <20100618121552.GA19044@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov wrote:
> >+extern unsigned long arch_randomize_brk(struct mm_struct *mm);
> >+#define arch_randomize_brk arch_randomize_brk
> 
>    Isn't this an "infinitely recursive" macro?

Not in ISO C.  It'll expand to itself and stop.  This is a handy trick
for confirming #ifdef tests elsewhere.  Glibc does it a lot for enums
defined in header files, for those which applications commonly test
with #ifdef because they were traditionally defined using macros.

-- Jamie
