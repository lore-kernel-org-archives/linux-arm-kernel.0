From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 17 Nov 2009 10:15:49 +0100
Subject: [PATCH] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
In-Reply-To: <20091117091024.187d7cda@hina.wild-wind.fr.eu.org>
References: <1258444074-20679-1-git-send-email-m.szyprowski@samsung.com>
	<20091117091024.187d7cda@hina.wild-wind.fr.eu.org>
Message-ID: <000701ca6766$90fbb2e0$b2f318a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, November 17, 2009 9:10 AM Marc Zyngier wrote:

> On Tue, 17 Nov 2009 08:47:54 +0100
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > Samsung S5PC1xx SoCs are Coretex8 based, so use 64 bytes of L1 cache
> > line instead of the default 32 bytes.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >  arch/arm/mm/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index 9264d81..7b7d4c3 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -774,5 +774,5 @@ config CACHE_XSC3L2
> >
> >  config ARM_L1_CACHE_SHIFT
> >  	int
> > -	default 6 if ARCH_OMAP3
> > +	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> >  	default 5
> 
> If this feature is related to the S5PC1xx being a CortexA8, why not
> depend on CPU_V7 rather that adding each and every new CortexA8
> implementation to this list?

There can be ARM v7 CPUs with different size of L1 line cache -
Cortex-R4 is an example of such: 
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0363d/Caccifbd.html
(32 bytes of L1 cache line size).

This config option should depend on particular ARM core implementation,
otherwise it will be hard cover all possibilities.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
