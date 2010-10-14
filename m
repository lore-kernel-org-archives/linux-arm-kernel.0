From: jongsun.han@samsung.com (Jongsun Han)
Date: Fri, 15 Oct 2010 08:55:03 +0900
Subject: [PATCH V2 2/2] ARM: S5PV310: Add support GPIOlib
In-Reply-To: <006501cb6b5f$f9bd29a0$ed377ce0$%kim@samsung.com>
References: <1286868876-3748-1-git-send-email-sbkim73@samsung.com>
	<1286868876-3748-3-git-send-email-sbkim73@samsung.com>
	<006501cb6b5f$f9bd29a0$ed377ce0$%kim@samsung.com>
Message-ID: <00e201cb6bfb$38aaebc0$aa00c340$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> >
> > From: Jongpill Lee <boyko.lee@samsung.com>
> >
> > This patch adds GPIOlib support for S5PV310 and S5PC210.
> >
> > Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> > Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> > ---
> > NOTE:
> > This patch used mapped VA IO as GPIO virtual address.
> > because firstly other Samsung SoC's GPIO used same method.
> > and I think that  it's better to keep the same method.
> > And ioremap also can be used for it.
> > But in the GPIO, there is no need to allocate VA area dynamically.
> > because GPIO can be used in any drivers anytime so it can't iounmap GPIO
> > VA area.
> >
> Ok...
> 
> (snip)
> 
> >  #define MAX_COMBINER_NR		40
> >
> > +#define S5P_IRQ_EINT_BASE	COMBINER_IRQ(MAX_COMBINER_NR, 0)
> > +
> > +#define S5P_EINT_BASE1		(S5P_IRQ_EINT_BASE + 0)
> > +#define S5P_EINT_BASE2		(S5P_IRQ_EINT_BASE + 16)
> > +
> 
> Hmm...
> If you want to add external interrupt, should be changed NR_IRQS too.
> 
> Will apply with fixing NR_IRQS.
> 

It seems that S5P_IRQ_EINT_BASE has wrong definition.
S5P_IRQ_EINT_BASE has to be COMBINER_IRQ(MAX_COMBINER_NR - 1, 0).

Thanks.

> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
