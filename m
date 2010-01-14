From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Jan 2010 15:55:48 +0900
Subject: [PATCH v5 1/8 RE-SEND] ARM: S5P6440: Add new CPU	initialization
	support
In-Reply-To: <20100114061322.GN3738@trinity.fluff.org>
References: <1263443210-31699-1-git-send-email-kgene.kim@samsung.com>
	<20100114061322.GN3738@trinity.fluff.org>
Message-ID: <000f01ca94e6$9a93d910$cfbb8b30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
> On Thu, Jan 14, 2010 at 01:26:50PM +0900, Kukjin Kim wrote:
> > This patch adds Samsung's S5P6440 CPU support.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---

(snip)

> > diff --git a/arch/arm/plat-s3c/include/plat/cpu.h b/arch/arm/plat-
> s3c/include/plat/cpu.h
> > index d1131ca..d8e134c 100644
> > --- a/arch/arm/plat-s3c/include/plat/cpu.h
> > +++ b/arch/arm/plat-s3c/include/plat/cpu.h
> > @@ -48,9 +48,11 @@ extern void s3c_init_cpu(unsigned long idcode,
> >
> >  extern void s3c24xx_init_irq(void);
> >  extern void s3c64xx_init_irq(u32 vic0, u32 vic1);
> > +extern void s5p_init_irq(u32 *vic, u32 num_vic);
> >
> >  extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
> >  extern void s3c64xx_init_io(struct map_desc *mach_desc, int size);
> > +extern void s5p_init_io(struct map_desc *mach_desc, int size);
> 
> This is being used by smdk6440 with three arguments, which is causing
> the build of the overall series to fail.

Hi Ben,

Yes, you're right.
I missed something.
So I will re-send.

> >  extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
> >


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
