From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 07 Oct 2010 11:02:39 +0200
Subject: [PATCH 2/7] ARM: S5PC110: Fix wrong interrupt I2C2 number
In-Reply-To: <004401cb65bf$ec00b7a0$c40226e0$%kim@samsung.com>
References: <20100930044827.GA16901@july>
	<004401cb65bf$ec00b7a0$c40226e0$%kim@samsung.com>
Message-ID: <018501cb65fe$677dfe40$3679fac0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, October 07, 2010 3:35 AM Kukjin Kim wrote:

> Kyungmin Park wrote:
> >
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > It's I2C2 interrupt number instead of CAN0.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-s5pv210/include/mach/irqs.h |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5pv210/include/mach/irqs.h b/arch/arm/mach-
> > s5pv210/include/mach/irqs.h
> > index cdb8ae4..5ab1833 100644
> > --- a/arch/arm/mach-s5pv210/include/mach/irqs.h
> > +++ b/arch/arm/mach-s5pv210/include/mach/irqs.h
> > @@ -55,8 +55,8 @@
> >  #define IRQ_SPI1		S5P_IRQ_VIC1(16)
> >  #define IRQ_SPI2		S5P_IRQ_VIC1(17)
> >  #define IRQ_IRDA		S5P_IRQ_VIC1(18)
> > -#define IRQ_CAN0		S5P_IRQ_VIC1(19)
> > -#define IRQ_CAN1		S5P_IRQ_VIC1(20)
> > +#define IRQ_IIC2		S5P_IRQ_VIC1(19)
> > +#define IRQ_I2C_HDMI_PHY	S5P_IRQ_VIC1(20)
> >  #define IRQ_HSIRX		S5P_IRQ_VIC1(21)
> >  #define IRQ_HSITX		S5P_IRQ_VIC1(22)
> >  #define IRQ_UHOST		S5P_IRQ_VIC1(23)
> > --
> 
> Please refer to my other comments.
> 
> Hmm...I think, no need to change to IRQ_I2C_HDMI_PHY...in here.
> If required, we can do it later...and how about IRQ_IIC_HDMI_PHY like other
> IRQ_IIC?

IMHO the best option would be to call it just IRQ_IIC3. This way it would be
possible just to use the dev-i2c3 from the next patch in this series (once a
dummy setup-i2c3 will be provided for s5pv210). Otherwise we would need to
create a special dev-i2c-hdmiphy.c just for this case what would be an overhead
imho.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
