From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 26 Jul 2011 17:51:16 -0700
Subject: [GIT PULL] arm-soc new features (part 2/2) for 3.1
In-Reply-To: <5039974.y3GReu3Vjy@wuerfel>
References: <3057645.NjCAYUXHGt@wuerfel> <5818290.TCY0zMWmbr@wuerfel>
	<1698068.Mn9Tmtfmzl@wuerfel> <5039974.y3GReu3Vjy@wuerfel>
Message-ID: <CA+55aFygBzynb_4kZQEHQAU0Np0H9UCBFoW1hoRJ571QCMo42Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 4:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> This is the final branch I have for now, although I hope to get one more
> for actual device tree conversions for a lot of drivers.

Ok, everything merged.

I compared the end result with yours, and we did some things a bit
differently, but on the whole it looks pretty identical. We have a
different resolution for "exynos4_cpu_suspend()", but afaik mine is
better (it looks like from a type standpoint it should return int, but
due to the panic it doesn't matter). And we did those
OMAP4430_DLL_OVERRIDE_SHIFT/MASK defines in a different order. I have
some other changes in my tree (Andrew's patch-set for asm/atomic.h
etc), so that makes for other differences in arch/arm, but it looks
like it's ok.

But you should double-check. I didn't compile-test any of it, I don't
do the cross-compile thing, and maybe I missed something.

                       Linus
