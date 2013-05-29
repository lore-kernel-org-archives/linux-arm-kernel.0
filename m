From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 29 May 2013 16:15:55 +0100
Subject: Single zImage and A15/LPAE
In-Reply-To: <2274563.opVbLLPT1p@wuerfel>
References: <50735B75.8070109@wwwdotorg.org>
 <alpine.LFD.2.03.1305282148560.1918@syhkavp.arg>
 <CAOesGMh+XHueA0UtnAzYTkysqdLqs93Bp31KJKsqVBa-LkiQbQ@mail.gmail.com>
 <2274563.opVbLLPT1p@wuerfel>
Message-ID: <20130529151555.GP17767@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 02:01:05PM +0100, Arnd Bergmann wrote:
> On Tuesday 28 May 2013 19:02:48 Olof Johansson wrote:
> > On Tue, May 28, 2013 at 6:54 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > On Wed, 29 May 2013, Kukjin Kim wrote:
> > >> (+ Olof, Russell)
> > >>
> > >> Just note, I found this in my old mail-box...
> > >>
> > >> So I think, as a result, we need to support separate kernel binary for LPAE
> > >> and non-LPAE and you guys don't hold a different view about it.
> > >
> > > LPAE and non-LPAE configurations will most likely never be supported
> > > together in the same kernel binary.  The runtime cost would simply be
> > > too high to be worth it.
> > >
> > >> Current SSDK5440 and SD5v1 boards which are reference boards for EXYNOS5440
> > >> has over 4GB memory as a default and that's why I'm writing this e-mail. It
> > >> means I should keep separated kernel to support exynos5440 and other exynos
> > >> SoCs.
> > >
> > > They could all be supported together but with less than 4GB of memory.
> > 
> > Or the other way around, the other EXYNOS5 CPUs could all enable LPAE
> > even if they have less than 4GB of memory -- but not EXYNOS4, of
> > course.
> 
> The one bug I see is that it's currently possible to build a kernel
> for a Cortex-A5/A8/A9, Scorpion or PJ4 platform with LPAE enabled,
> which obviously cannot work.
> 
> I think to do this right, we need to treat ARMv7+LPAE as a separate
> architecture level, just like we treat ARMv6, ARMv7 as separate
> compatible architectures. BTW, is there an official name for that
> architecture?

The official is Large Physical Address Extension which is an extension
to ARMv7, so not a new architecture.

-- 
Catalin
