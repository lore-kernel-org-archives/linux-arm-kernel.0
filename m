From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 19:30:36 +0900
Subject: [PATCH 1/9] ARM: EXYNOS: use exynos_init_uarts() instead of
 exynos4_init_uarts()
In-Reply-To: <CAH9JG2VQBA3PFOm-gcP=igetQyCHs+Qc_zWJgGNLuMpq948yVg@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-2-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2VQBA3PFOm-gcP=igetQyCHs+Qc_zWJgGNLuMpq948yVg@mail.gmail.com>
Message-ID: <068001cce715$dc50bcf0$94f236d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Since exynos4_init_uarts() can be used for EXYNOS5 SoCs,
> > this patch changes the name of function to exynos_init_uarts().
> >

[snip]

> >
> >  #ifdef CONFIG_ARCH_EXYNOS
> >  extern  int exynos_init(void);
> > +extern void exynos_init_uarts(struct s3c2410_uartcfg *cfg, int no);
> >  extern void exynos4_map_io(void);
> >  extern void exynos4_init_clocks(int xtal);
> > -extern void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
> 
> Are there any cases build without CONFIG_ARCH_EXYNOS?
> I think it's always defined CONFIG_ARCH_EXYNOS.
> 
Right, we don't need. It will be fixed.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
