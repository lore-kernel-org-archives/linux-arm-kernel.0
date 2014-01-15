From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 14:19:23 +0100
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
In-Reply-To: <CACRpkda=p6GnpuNQizdQA1gGuOe8Lnsp+r8rQedWCRog2MRHww@mail.gmail.com>
References: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
 <6144980.CZru2D3yJB@wuerfel>
 <CACRpkda=p6GnpuNQizdQA1gGuOe8Lnsp+r8rQedWCRog2MRHww@mail.gmail.com>
Message-ID: <201401151419.24423.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014, Linus Walleij wrote:
> When I look at it, the issue also exist in e.g.
> drivers/gpio/gpio-samsung.c which can be compiled
> (like for allyesconfig) when PLAT_SAMSUNG is set.
> 
> And it is also set to y for ARCH_EXYNOS... which
> doesn't have any custom GPIO header. So this would
> involve something like creating an empty
> <mach/gpio-samsung.h> for Exynos which doesn't
> seem like the right thing to do.

Ah, right. I looked at this before, but I misremembered about
PLAT_SAMSUNG and thought it was fine because ARCH_EXYNOS no
longer implied PLAT_SAMSUNG. That was wrong, instead ARCH_EXYNOS
still sets PLAT_SAMSUNG but not PLAT_S5P as it used to.

> So I'm sticking with the #ifdef patch for now as it
> seems to be the lesser evil :-/

Yes, agreed.

	Arnd
