From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 3 May 2017 23:32:09 +0300
Subject: [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock.c
In-Reply-To: <CAMuHMdXks7pXcg+MNvqYyRWHf-WUrNWLrG8GcPWy8ho49Wx7ug@mail.gmail.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <20170503145141.4966-2-ynorov@caviumnetworks.com>
 <CAMuHMdXks7pXcg+MNvqYyRWHf-WUrNWLrG8GcPWy8ho49Wx7ug@mail.gmail.com>
Message-ID: <20170503203209.ilcifmyqxkv2igq3@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 05:05:29PM +0200, Geert Uytterhoeven wrote:
> On Wed, May 3, 2017 at 4:51 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > --- a/kernel/locking/qrwlock.c
> > +++ b/kernel/locking/qrwlock.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/cpumask.h>
> >  #include <linux/percpu.h>
> >  #include <linux/hardirq.h>
> > +#include <asm/spinlock.h>
> 
> linux/spinlock.h?

Comment in include/linux/spinlock.h says:

 * here's the role of the various spinlock/rwlock related include
 * files:
 *
 * on SMP builds:
 *
 [...]
 *  asm/spinlock.h:       contains the arch_spin_*()/etc.  lowlevel
 *                        implementations, mostly inline assembly code
 *

This, and the fact that include/asm-generic/spinlock.h and
arch/arm64/include/asm/spinlock.h doesn't prevent the direct
inclusion means, for me, that I should include asm/spinlock.h,
because of all that I need only arch_spin_lock() and arch_spin_unlock().

Am I wrong?

Yury
