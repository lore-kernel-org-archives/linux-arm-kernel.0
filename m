From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 12:11:38 +0100
Subject: [PATCH v9 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
In-Reply-To: <54783899.2060604@samsung.com>
References: <1416224909-4290-1-git-send-email-m.szyprowski@samsung.com>
 <20141127225100.GA3840@n2100.arm.linux.org.uk> <54783899.2060604@samsung.com>
Message-ID: <3059840.P4aX5Il9dy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 09:55:53 Marek Szyprowski wrote:
> On 2014-11-27 23:51, Russell King - ARM Linux wrote:
> > On Mon, Nov 17, 2014 at 12:48:22PM +0100, Marek Szyprowski wrote:
> >>
> >> Changes in this version tested on Exynos4412-based TRATS2 and OdroidU3+
> >> boards (both with secure firmware). There should be no functional change
> >> for Exynos boards running without secure firmware. I do not have access
> >> to affected non-Exynos boards, so I could not test on them.
> > So, I applied this series, and now I get a conflicts between my tree and
> > arm-soc for:
> >
> > arch/arm/mach-exynos/firmware.c
> > arch/arm/mach-exynos/sleep.S
> >
> > So, I'm going to un-stage the exynos bits, and we'll have to work out
> > some way to handle those.

Ok

> I've already pointed that those patches depend on other previously merged to
> exynos and arm-soc trees, but both Arnd and Kukjin said that those patch 
> series
> should go via your kernel tree:
> 
> https://lkml.org/lkml/2014/11/15/158
> 
> That's why in v9 I rebased patches once again onto vanilla v3.18-rc4 and 
> uploaded
> to your patch tracker. I see the following two possibilities to get them 
> merged:
> 
> 1. Merge patches to rmk tree and resolve the merge conflict. The 
> conflict IS quite
> easy to resolve - both trees, arm-soc and rmk only adds some code and 
> the goal is
> simply to have both chunks added.
> 
> 2. Merge the previous version (v8 from the above link) to arm-soc tree, 
> where it
> applies cleanly on for-next, preferably with Russell's Acked-by.
> 
> Arnd, Russell: which approach do you prefer? How can I help to get it 
> merged?

I'm fine with it either way. Russell, if you like you can merge
http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung v3.19-next/pm-samsung-2
into your tree and resolve the conflict on your end, we have a stable
copy of that branch queued in next/soc.

If you prefer v8 to go through arm-soc, that's fine with me too, or
we could share a branch with v9 of Marek's series and have that merged
into arm-soc/next/soc to resolve the conflict.

	arnd
