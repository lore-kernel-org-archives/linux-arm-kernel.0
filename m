From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 14:19:16 +0900
Subject: [PATCH v2 08/11] ARM: EXYNOS: add support for ARCH_EXYNOS5 and
 EXYNOS5250
In-Reply-To: <201202160515.00068.arnd@arndb.de>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-9-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2Usa5k0J0uoyOPxnPG5y9bZAFD+5AR43mbFN04P7t3Npw@mail.gmail.com>
 <201202160515.00068.arnd@arndb.de>
Message-ID: <054501ccec6a$872fb140$958f13c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> On Thursday 16 February 2012, Kyungmin Park wrote:
> > >
> > > +config ARCH_EXYNOS5
> > > +     bool "SAMSUNG EXYNOS5"
> > > +     select HAVE_SMP
> > > +     help
> > > +       Samsung EXYNOS5 (Cortex-A15) SoC based systems
> > This config is located at choice. It means it can't build the exynos4
> > and exynos5 simultaneously. I'm not sure it's acceptable for mainline.
> 
> If we use the new common struct clk on exynos5 but not exynos4, it should
> stay a "choice" for the time being and get turned into a nonexclusive
> selection as soon as exynos4 moves over.
> 
Yes, right.

> If exynos4 and exynos5 end up using the same struct clk in 3.4, I would
> indeed ask to do this change now.
> 
If possible, yes. But I'm going to move common struct clk for exynos4 and exynos5 next time.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
