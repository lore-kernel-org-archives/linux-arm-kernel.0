From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 06 Oct 2015 19:09:58 +0900
Subject: [PATCH 0/2] ARM: EXYNOS: Allow to use architected timer
In-Reply-To: <00d801d10014$e6d994a0$b48cbde0$@samsung.com>
References: <cover.1444119342.git.p.fedin@samsung.com>
 <6613638.q5qyQZxXy7@wuerfel> <00d801d10014$e6d994a0$b48cbde0$@samsung.com>
Message-ID: <187701d1001f$284b1350$78e139f0$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Fedin wrote:
> 
>  Hello!
> 
> > IIRC the use of the CP15 timer is not reliable on this platform.
> > I don't have a link ready, but this has come up a few times.
> 
>  I know that Samsung SoC guys are not very keen on this, therefore i actually made this optional.

No, it's not a good way and it's not an optional problem...I think, I already
commented many times about that...If we can arch timer on exynos stuff, why we
are still using MCT...? hmm...

> If
> you want, you could omit the second patch, and by default Exynos platform will use MCT. But if
> someone wants to use KVM, it would be enough only to modify device tree in order to enable CP15.
> Would this be a good compromise?
> 
No, because the MCT should be used by default _always_ and it is depending on hardware scheme...

> > Regarding KVM usage, would it be possible to emulate the architected
> > timer from qemu instead?
> 
>  Unfortunately no. Accesses to virtual timer registers cannot be trapped. It is possible to trap
> physical timer accesses, and trick the kernel into using it, but it's slow, and it is a different
> story, which you can read here: http://www.spinics.net/lists/kvm/msg121714.html.
>  So, i think that having an option to use CP15 would be a good solution. It is known to work, and i
> use this configuration here on SMDK5410 without any problems.
> 
Actually Exynos5410 has been designed differently so it is safe only on smdk5410 not others...

- Kukjin
