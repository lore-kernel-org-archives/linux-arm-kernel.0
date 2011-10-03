From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Oct 2011 12:27:12 +0900
Subject: [PATCH 2/2] ARM: SAMSUNG: Cleanup resources by using macro
In-Reply-To: <20111002110724.GT11710@n2100.arm.linux.org.uk>
References: <001e01cc80e5$1c9eb150$55dc13f0$%kim@samsung.com>
	<20111002110724.GT11710@n2100.arm.linux.org.uk>
Message-ID: <005601cc817c$577cdb70$06769250$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> On Sun, Oct 02, 2011 at 06:24:40PM +0900, Kukjin Kim wrote:
> > This patch adds macro SAMSUNG_RES_MEM and SAMSUNG_RES_IRQ to
> cleanup
> > regarding 'struct resource'
> 
> Why not include the braces inside the macro as well?
> 
I thought, if other member such as name is required additionally, can add it
like following.

[0] = { SAMSUNG_RES_MEM(xxx, xxx, xxx), .name = "xxx" },

But below helpers can do it :)

> > diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-
> samsung/include/plat/devs.h
> > index 8f19241..8b8bd1c 100644
> > --- a/arch/arm/plat-samsung/include/plat/devs.h
> > +++ b/arch/arm/plat-samsung/include/plat/devs.h
> > @@ -18,6 +18,16 @@
> >
> >  #include <linux/platform_device.h>
> >
> > +#define SAMSUNG_RES_MEM(soc, ip, sz)			\
> > +		.start	= soc##_PA_##ip,		\
> > +		.end	= soc##_PA_##ip + sz - 1,	\
> > +		.flags	= IORESOURCE_MEM,
> > +
> > +#define SAMSUNG_RES_IRQ(ip)				\
> > +		.start	= IRQ_##ip,			\
> > +		.end	= IRQ_##ip,			\
> > +		.flags	= IORESOURCE_IRQ,
> > +
> 
> How about using DEFINE_RES_MEM and DEFINE_RES_IRQ here?
> 
> #define SAMSUNG_RES_MEM(soc, ip, sz) DEFINE_RES_MEM(soc##_PA_##ip,
> sz)
> #define SAMSUNG_RES_IRQ(ip) DEFINE_RES_IRQ(IRQ_##ip)

Great, I don't know why I couldn't find it and nobody use it now...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
