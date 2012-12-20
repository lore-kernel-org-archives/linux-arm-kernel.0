From: zhanzhenbo@gmail.com (steve.zhan)
Date: Thu, 20 Dec 2012 22:02:04 +0800
Subject: [PATCH] hwspinlock/core: Kernel panic when enable
 DEBUG_SPINLOCK_SLEEP config.
In-Reply-To: <CAK=WgbbWNEJB79iPURdYM52HtoyvsFeoEUvfodwWg5qvtMhQyQ@mail.gmail.com>
References: <CAKvkGKcLU4ehteAqozw6+dCodSoQvJRSkpnu85um0C62c7RzSg@mail.gmail.com>
 <CAK=WgbbWNEJB79iPURdYM52HtoyvsFeoEUvfodwWg5qvtMhQyQ@mail.gmail.com>
Message-ID: <CAKvkGKd8YSm0BDmaOTRh8P5O4tvQ7+D-9d=MoGf0CrG_noBcsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Ohad,
             Thank you. The kernel version is
3.4.-rc6(android-3.4-compat  kernel version). I have
checkout 93b465c2e186d96fb90012ba0f9372eb9952e732 and that is  good
solution using mutex protect these interface.


steve.


2012/12/20 Ohad Ben-Cohen <ohad@wizery.com>

> Hello Steve,
>
> On Thu, Dec 20, 2012 at 2:44 PM, steve.zhan <zhanzhenbo@gmail.com> wrote:
> >                 When enable this config to check kernel, kernel will
> > complain panic at slab.c(kmem_cache_alloc function): "BUG: sleeping
> function
> > called from invalid context".
>
> Which kernel version are you using ?
>
> Specifically, do you have commit
> 93b465c2e186d96fb90012ba0f9372eb9952e732 "hwspinlock/core: use a mutex
> to protect the radix tree" ?
>
> Thanks,
> Ohad.
>



-- 
Steve Zhan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121220/a42d65e5/attachment-0001.html>
