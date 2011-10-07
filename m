From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 07 Oct 2011 19:42:22 +0900
Subject: [PATCH v3 1/2] ARM: EXYNOS4: Change System MMU device	definition
In-Reply-To: <20111007102754.GF21464@n2100.arm.linux.org.uk>
References: <01e001cc84d7$5e0b84b0$1a228e10$%kim@samsung.com>
	<20111007102754.GF21464@n2100.arm.linux.org.uk>
Message-ID: <01eb01cc84dd$cb740940$625c1bc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Fri, Oct 07, 2011 at 06:56:21PM +0900, Kukjin Kim wrote:
> > +#define SYSMMU_RESOURCE(ipname, base, irq) \
> > +static struct resource sysmmu_resource_##ipname[] =\
> > +{\
> > +	{\
> > +		.start	= EXYNOS4_PA_SYSMMU_##base,\
> > +		.end	= EXYNOS4_PA_SYSMMU_##base + SZ_4K - 1,\
> > +		.flags	= IORESOURCE_MEM,\
> > +	}, {\
> > +		.start	= IRQ_SYSMMU_##irq##_0,\
> > +		.end	= IRQ_SYSMMU_##irq##_0,\
> > +		.flags	= IORESOURCE_IRQ,\
> > +	},\
> >  }
> 
> #define SYSMMU_RESOURCE(ipname, base, irq) \
> static struct resource sysmmu_resource_##ipname[] = \
> { \
> 	DEFINE_RES_MEM(EXYNOS4_PA_SYSMMU_##base, SZ_4K), \
> 	DEFINE_RES_IRQ(IRQ_SYSMMU_##irq##_0), \
> }

Oops, I missed that.
OK, let him change it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
