From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 16 Jul 2013 13:01:18 +0900
Subject: Single zImage and A15/LPAE
In-Reply-To: <201305292351.41096.arnd@arndb.de>
References: <50735B75.8070109@wwwdotorg.org> <2274563.opVbLLPT1p@wuerfel>
 <20130529151555.GP17767@MacBook-Pro.local> <201305292351.41096.arnd@arndb.de>
Message-ID: <028201ce81d9$200ecbd0$602c6370$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Wednesday 29 May 2013, Catalin Marinas wrote:
> > > I think to do this right, we need to treat ARMv7+LPAE as a separate
> > > architecture level, just like we treat ARMv6, ARMv7 as separate
> > > compatible architectures. BTW, is there an official name for that
> > > architecture?
> >
> > The official is Large Physical Address Extension which is an extension
> > to ARMv7, so not a new architecture.
> 
> Ah, too bad. I had hoped there were still postfixes like v6K or v4T.
> I guess there is no complete list of ARMv7 extensions anywhere, right?
> 
Just note, EXYNOS4 SoCs and EXYNOS5250 cannot boot when LPAE is enabled so I
think, single zImage should be handled separately for non-LPAE and LPAE. I
need to sort out EXYNOS SoCs for it and prepare registering
exynos5440_defconfig. Of course, EXYNOS5440 can be supported without LPAE
enabling but current bootargs in v3.11-rc1 break the kernel booting.

Thanks,
- Kukjin
