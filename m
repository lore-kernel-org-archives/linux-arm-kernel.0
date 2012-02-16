From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 14:23:00 +0900
Subject: [PATCH v2 08/11] ARM: EXYNOS: add support for ARCH_EXYNOS5 and
 EXYNOS5250
In-Reply-To: <CAH9JG2Usa5k0J0uoyOPxnPG5y9bZAFD+5AR43mbFN04P7t3Npw@mail.gmail.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <1328981685-8602-9-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2Usa5k0J0uoyOPxnPG5y9bZAFD+5AR43mbFN04P7t3Npw@mail.gmail.com>
Message-ID: <054601ccec6b$0c9292d0$25b7b870$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 

[...]

> >
> > +config ARCH_EXYNOS5
> > +	bool "SAMSUNG EXYNOS5"
> > +	select HAVE_SMP
> > +	help
> > +	  Samsung EXYNOS5 (Cortex-A15) SoC based systems
> This config is located at choice. It means it can't build the exynos4
> and exynos5 simultaneously. I'm not sure it's acceptable for mainline.

See Arnd's comments.

[...]

> > +obj-$(CONFIG_ARCH_EXYNOS5)	+= clock-exynos5.o
> Where's clock-exynos5.c file in this patch?. maybe it's another patch.

See 3rd patch.

[...]

> > +void exynos5_restart(char mode, const char *cmd)
> > +{
> > +	__raw_writel(0x1, EXYNOS_SWRESET);
> > +}
> Why new restart is required? it's same S5P_SWRESET and EXYNOS_SWRESET.
> see below.

It will be updated for exynos5.

[...]

> >
> >  #define S5P_SWRESET				S5P_PMUREG(0x0400)
> > +#define EXYNOS_SWRESET				S5P_PMUREG(0x0400)
> Please use just one.
> 
See above.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
