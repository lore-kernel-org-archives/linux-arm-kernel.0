From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 30 Oct 2012 10:39:14 +0000
Subject: linux-next: manual merge of the clk tree with the arm-soc tree
In-Reply-To: <20121030101140.18780.69840@nucleus>
References: <20121030150627.ac1f6a3f75231ea49edf7b98@canb.auug.org.au>
 <20121030101140.18780.69840@nucleus>
Message-ID: <1351593554.2831.8.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-30 at 10:11 +0000, Mike Turquette wrote:
> > diff --cc arch/arm/include/asm/hardware/sp810.h
> > index 2cdcf44,afd7e91..0000000
> > --- a/arch/arm/include/asm/hardware/sp810.h
> > +++ b/arch/arm/include/asm/hardware/sp810.h
> > @@@ -50,6 -50,14 +50,8 @@@
> >   #define SCPCELLID2            0xFF8
> >   #define SCPCELLID3            0xFFC
> >   
> >  -#define SCCTRL_TIMEREN0SEL_REFCLK     (0 << 15)
> >  -#define SCCTRL_TIMEREN0SEL_TIMCLK     (1 << 15)
> >  -
> >  -#define SCCTRL_TIMEREN1SEL_REFCLK     (0 << 17)
> >  -#define SCCTRL_TIMEREN1SEL_TIMCLK     (1 << 17)
> >  -
> > + #define SCCTRL_TIMERENnSEL_SHIFT(n)   (15 + ((n) * 2))
> > + 
> >   static inline void sysctl_soft_reset(void __iomem *base)
> >   {
> >         /* switch to slow mode */
> 
> Pawel,
> 
> Does this look OK for you?

Yes, it's correct.

Thanks!

Pawe?
