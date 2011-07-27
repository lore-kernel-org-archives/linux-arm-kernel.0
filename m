From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jul 2011 17:07:53 +0200
Subject: [GIT PULL] arm-soc new features (part 2/2) for 3.1
In-Reply-To: <CA+55aFygBzynb_4kZQEHQAU0Np0H9UCBFoW1hoRJ571QCMo42Q@mail.gmail.com>
References: <3057645.NjCAYUXHGt@wuerfel> <5039974.y3GReu3Vjy@wuerfel>
	<CA+55aFygBzynb_4kZQEHQAU0Np0H9UCBFoW1hoRJ571QCMo42Q@mail.gmail.com>
Message-ID: <201107271707.54059.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 July 2011, Linus Torvalds wrote:
> I compared the end result with yours, and we did some things a bit
> differently, but on the whole it looks pretty identical. We have a
> different resolution for "exynos4_cpu_suspend()", but afaik mine is
> better (it looks like from a type standpoint it should return int, but
> due to the panic it doesn't matter). And we did those
> OMAP4430_DLL_OVERRIDE_SHIFT/MASK defines in a different order. I have
> some other changes in my tree (Andrew's patch-set for asm/atomic.h
> etc), so that makes for other differences in arch/arm, but it looks
> like it's ok.
> 
> But you should double-check. I didn't compile-test any of it, I don't
> do the cross-compile thing, and maybe I missed something.

Looks all good as far as I can tell. Your exynos4_cpu_suspend is
better than the solution I had in next and everything else
is equivalent.

I'm still in the process of fixing randconfig builds that have never
been working for most arm platforms, so I can do a better job
at automatically doing build tests myself. My guess is that there
will be several build regressions due to stuff coming in but that
they are not the result of mismerges.

	Arnd
