From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 May 2014 13:37:33 +0900
Subject: [PATCH 5/6] ARM: EXYNOS: Enable multi-platform build support
In-Reply-To: <201404222156.48432.arnd@arndb.de>
References: <1397554134-11827-1-git-send-email-sachin.kamat@linaro.org>
 <1397554134-11827-6-git-send-email-sachin.kamat@linaro.org>
 <CAOesGMh0VdSbQ1fSjGkJOG+BDeNfo4NNQjtiznh18DxSROaT1A@mail.gmail.com>
 <201404222156.48432.arnd@arndb.de>
Message-ID: <065d01cf6e65$0e903dc0$2bb0b940$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Tuesday 22 April 2014, Olof Johansson wrote:
> > I don't think there's a point in keeping this around. A
> > "single-platform" config is just enabling a single platform in the
> > config, it's not a specific option. I don't think any of the other
> > platforms use anything like this today.
> 
> The only one doing that is shmobile, but only because they have
> some SoCs that are multiplatform capable and some that are not.
> This isn't the case for Exynos, so it should no longer be needed.
> 
> When I originally created this patch 18 months ago, there were a
> number of drivers that broke when multiplatform got enabled.
> Now the cpufreq driver is the only one left, but it seems that
> it will make it for 3.16, and I wouldn't wait for it if it doesn't.
> Let's just do multiplatform-only.
> 
In my position in S.LSI, I'd like to keep the current ARCH_EXYNOS4 and
EXYNOS5 because IMHO selecting each series would be helpful on real product,
multiplatform is available though. Additionally EXYNOS3 is being added.

It's true we can support exynos-multiplatform even though above options are
included...

Thanks,
Kukjin
