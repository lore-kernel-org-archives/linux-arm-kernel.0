From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 1 Oct 2010 14:49:18 +0200
Subject: [PATCH 2/2] Adding cs89x0, standard ethernet driver for iMX31
	platform.
In-Reply-To: <1285929996.1864.11438.camel@Tapajos>
References: <1285861655-6513-1-git-send-email-ian@opensource.wolfsonmicro.com>
	<1285861655-6513-2-git-send-email-ian@opensource.wolfsonmicro.com>
	<20100930182313.GT29811@pengutronix.de>
	<1285929996.1864.11438.camel@Tapajos>
Message-ID: <20101001124918.GM784@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 11:46:36AM +0100, Ian Lartey wrote:
> On Thu, 2010-09-30 at 20:23 +0200, Uwe Kleine-K?nig wrote:
> > On Thu, Sep 30, 2010 at 04:47:35PM +0100, Ian Lartey wrote:
> > > Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> > > ---
> > >  arch/arm/configs/mx3_defconfig |    2 ++
> > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/configs/mx3_defconfig b/arch/arm/configs/mx3_defconfig
> > > index 161f907..b0b3409 100644
> > > --- a/arch/arm/configs/mx3_defconfig
> > > +++ b/arch/arm/configs/mx3_defconfig
> > > @@ -68,6 +68,8 @@ CONFIG_NET_ETHERNET=y
> > >  CONFIG_SMSC911X=y
> > >  CONFIG_DNET=y
> > >  CONFIG_FEC=y
> > > +CONFIG_CS89x0=y
> > > +CONFIG_CS89x0_NONISA_IRQ=y
> > >  # CONFIG_NETDEV_1000 is not set
> > >  # CONFIG_NETDEV_10000 is not set
> > >  # CONFIG_INPUT is not set
> > This change is bad for two reasons:
> > 
> >  - I just tested a kernel with CONFIG_CS89x0=y on a Phytec Phycore
> >    pcm043 using your updated defconfig and it barfs:
> > 
> > 	[.....]
> 
> Ouch, I'll see if I can correct that. (Needs to be done before I can add
> the config file change). Uwe I don't have another i.MX3 (apart from the
> i.MV31ADS) would you be able to test further changes for me please to
> help catch this kind of thing ?
I'm not sure if I have access to an mx31ads, but we have several i.MX
machines in our lab.  And I'm willing to give my comments to a general
cs89x0 cleanup.  (This drivers was one of the first things I saw when I
started kernel development.  Back then I gave up trying to understand
it. :-)  So maybe if you don't come around fixing it I might have some
energy to do it now with more knowledge about the kernel in general and
having seen *much* ugly code.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
