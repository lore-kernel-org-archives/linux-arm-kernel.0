From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 20:12:50 +0900
Subject: [PATCH 4/9] ARM: EXYNOS: add support for ARCH_EXYNOS5 and
 EXYNOS5250
In-Reply-To: <CAH9JG2UGCg=vNe-xKYdJzwQYExRK9U6xSRmHxSUxUruUCc3r4g@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-5-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2UGCg=vNe-xKYdJzwQYExRK9U6xSRmHxSUxUruUCc3r4g@mail.gmail.com>
Message-ID: <068d01cce71b$c2f87da0$48e978e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:

[snip]

> >  machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos
> > +machine-$(CONFIG_ARCH_EXYNOS5)		:= exynos
> It already has CONFIG_ARCH_EXYNOS so it's enough
> machine-$(CONFIG_ARCH_EXYNOS) := exynos

Basically I'd like to keep the ARCH_EXYNOS4 and ARCH_EXYNOS5 it can be a
duplicated line though. Because it is a different core.

[snip]

> > +config ARCH_EXYNOS5
> > +	bool "SAMSUNG EXYNOS5"
> > +	select HAVE_SMP
> > +	help
> > +	  Samsung EXYNOS5 SoCs based systems
> It's helpful to add which ARM core is used. in case of exynos4 has
> CA9, exynos5 has CA15.

Looks good, ok, the description of Cortex-A9 and Cortex-A15 will be added.

[snip]

> > +config SOC_EXYNOS5250
> > +	bool "SAMSUNG EXYNOS5250"
> > +	default y
> default y?

Yes. I think at least one SoC should be selected when one ARCH_ is selected.
And as you know, now ARCH_EXYNOS5 is used only for EXYNOS5250 SoC.

[snip]

> >  #define EXYNOS4_PA_SYSRAM0		0x02025000
> >  #define EXYNOS4_PA_SYSRAM1		0x02020000
> > +#define EXYNOS5_PA_SYSRAM		0x02020000
> Do you really use the single map file? Doesn't it better split each
series?

Now that would be better if could keep less headers.

[snip]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
