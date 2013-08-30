From: B38611@freescale.com (Duan Fugang-B38611)
Date: Fri, 30 Aug 2013 02:15:34 +0000
Subject: [PATCH] ARM: imx6sl: add imx6sl iomux-gpr field define
In-Reply-To: <20130829114548.GF18729@S2101-09.ap.freescale.net>
References: <1377168637-8676-1-git-send-email-B38611@freescale.com>
 <20130829114548.GF18729@S2101-09.ap.freescale.net>
Message-ID: <9848F2DB572E5649BA045B288BE08FBE01662AAA@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo [mailto:shawn.guo at linaro.org]
Data: Thursday, August 29, 2013 7:46 PM + 800

> To: Duan Fugang-B38611
> Cc: linux-arm-kernel at lists.infradead.org; bhutchings at solarflare.com;
> Estevam Fabio-R49496; Li Frank-B20596; Zhou Luwei-B45643
> Subject: Re: [PATCH] ARM: imx6sl: add imx6sl iomux-gpr field define
> 
> On Thu, Aug 22, 2013 at 06:50:37PM +0800, Fugang Duan wrote:
> > Add imx6sl iomux-gpr register field define in "imx6q-iomuxc-gpr.h"
> > header file, which is not fully define all iomux-gpr registers and
> > fields, only add fec related macro define.
> 
> I would suggest we have imx6sl-iomuxc-gpr.h if there is not so many things
> in common between imx6q and imx6sl iomuxc-gpr definitions.
> 
> Shawn
> 
As Robby's suggestion we would put the imx6q/dl iomux-gpr to one header files since the gpr register address/some feild define are the same.

> >
> > Signed-off-by: Fugang Duan  <B38611@freescale.com>
> > ---
> >  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > index b6bdcd6..7086b22 100644
> > --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> > @@ -363,4 +363,9 @@
> >  #define IMX6Q_GPR13_SATA_TX_LVL_1_240_V		(0x1f << 2)
> >  #define IMX6Q_GPR13_SATA_MPLL_CLK_EN		BIT(1)
> >  #define IMX6Q_GPR13_SATA_TX_EDGE_RATE		BIT(0)
> > +
> > +/* For imx6sl iomux gpr register field define */
> > +#define IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK    (0x3 << 17)
> > +#define IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK    (0x1 << 14)
> > +
> >  #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */
> > --
> > 1.7.1
> >
> >
