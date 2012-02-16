From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2012 05:14:59 +0000
Subject: [PATCH v2 08/11] ARM: EXYNOS: add support for ARCH_EXYNOS5 and
 EXYNOS5250
In-Reply-To: <CAH9JG2Usa5k0J0uoyOPxnPG5y9bZAFD+5AR43mbFN04P7t3Npw@mail.gmail.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-9-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2Usa5k0J0uoyOPxnPG5y9bZAFD+5AR43mbFN04P7t3Npw@mail.gmail.com>
Message-ID: <201202160515.00068.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2012, Kyungmin Park wrote:
> >
> > +config ARCH_EXYNOS5
> > +     bool "SAMSUNG EXYNOS5"
> > +     select HAVE_SMP
> > +     help
> > +       Samsung EXYNOS5 (Cortex-A15) SoC based systems
> This config is located at choice. It means it can't build the exynos4
> and exynos5 simultaneously. I'm not sure it's acceptable for mainline.

If we use the new common struct clk on exynos5 but not exynos4, it should
stay a "choice" for the time being and get turned into a nonexclusive
selection as soon as exynos4 moves over.

If exynos4 and exynos5 end up using the same struct clk in 3.4, I would
indeed ask to do this change now.

	Arnd
