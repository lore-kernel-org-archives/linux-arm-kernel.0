From: cl@linux.com (Christoph Lameter)
Date: Mon, 13 Sep 2010 08:58:41 -0500 (CDT)
Subject: Regression on UP ARM from commit
	e18d65f0500b95d8724b17d8ea9f1116cf390bbe
In-Reply-To: <AANLkTimC5Vz7x9+MNJcewijoyw=Nyr6WWP=YR8cxqarH@mail.gmail.com>
References: <AANLkTimC5Vz7x9+MNJcewijoyw=Nyr6WWP=YR8cxqarH@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1009130855430.26275@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Sep 2010, Linus Walleij wrote:

> commit e18d65f0500b95d8724b17d8ea9f1116cf390bbe
> "slub: Remove static kmem_cache_cpu array for boot"
> made my ARM 926 UP system hang at boot, if I revert this (have
> to back out a lot of SLUB patches for that) it comes back up. (Same if I
> switch to SLAB.)
>
> Any hints on how I can get patch around this in a nice way?

This is UP right? Any more details on this one? Does ARM have
earlyprintk?

Tejun also has some patches that make the percpu allocator work on UP so
that we do not need the hack (you must have the hack which is commit
c23e5ad729ac43f5e2fbc080f94cf61f07b4d45f as well to make UP work right!).

I am not sure if they are already in -next though.
