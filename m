From: ian@opensource.wolfsonmicro.com (Ian Lartey)
Date: Fri, 01 Oct 2010 11:46:36 +0100
Subject: [PATCH 2/2] Adding cs89x0, standard ethernet driver for iMX31
	platform.
In-Reply-To: <20100930182313.GT29811@pengutronix.de>
References: <1285861655-6513-1-git-send-email-ian@opensource.wolfsonmicro.com>
	<1285861655-6513-2-git-send-email-ian@opensource.wolfsonmicro.com>
	<20100930182313.GT29811@pengutronix.de>
Message-ID: <1285929996.1864.11438.camel@Tapajos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-30 at 20:23 +0200, Uwe Kleine-K?nig wrote:
> On Thu, Sep 30, 2010 at 04:47:35PM +0100, Ian Lartey wrote:
> > Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> > ---
> >  arch/arm/configs/mx3_defconfig |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
> > index 161f907..b0b3409 100644
> > --- a/arch/arm/configs/mx3_defconfig
> > +++ b/arch/arm/configs/mx3_defconfig
> > @@ -68,6 +68,8 @@ CONFIG_NET_ETHERNET=y
> >  CONFIG_SMSC911X=y
> >  CONFIG_DNET=y
> >  CONFIG_FEC=y
> > +CONFIG_CS89x0=y
> > +CONFIG_CS89x0_NONISA_IRQ=y
> >  # CONFIG_NETDEV_1000 is not set
> >  # CONFIG_NETDEV_10000 is not set
> >  # CONFIG_INPUT is not set
> This change is bad for two reasons:
> 
>  - I just tested a kernel with CONFIG_CS89x0=y on a Phytec Phycore
>    pcm043 using your updated defconfig and it barfs:
> 
> 	[.....]

Ouch, I'll see if I can correct that. (Needs to be done before I can add
the config file change). Uwe I don't have another i.MX3 (apart from the
i.MV31ADS) would you be able to test further changes for me please to
help catch this kind of thing ?
 
> 
>    (Did I already mention that this cs89x0 driver is ugly and needs a
>    general overhaul?)
> 

Yes, and I'm getting additional errors from the cs89x0 driver once it is
up and running so I was going to start looking for help once my changes
were in.... any volunteers ?

>  - adding "CONFIG_CS89x0_NONISA_IRQ=y" is redundant as it is always on
>    for MACH_MX31ADS.
> 
> So I suggest to just add CONFIG_CS89x0=m

Agreed.
 
> 
> Best regards
> Uwe
> 

Best Regards,
             Ian.
