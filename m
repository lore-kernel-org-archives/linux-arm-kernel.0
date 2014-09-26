From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 26 Sep 2014 08:46:31 +0000
Subject: [PATCH] ARM: Kconfig: Open force maximum zone order for all SoCs
In-Reply-To: <20140926084403.GK5182@n2100.arm.linux.org.uk>
References: <1409546541-4129-1-git-send-email-Li.Xiubo@freescale.com>
 <9dc024498c904d48b3a25430f8d31f29@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140926082054.GI5182@n2100.arm.linux.org.uk>
 <de6767070ea644d5830778059770451f@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140926084403.GK5182@n2100.arm.linux.org.uk>
Message-ID: <2a7514812fe243649466a41ccf13d424@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH] ARM: Kconfig: Open force maximum zone order for all SoCs
> 
> On Fri, Sep 26, 2014 at 08:39:04AM +0000, Li.Xiubo at freescale.com wrote:
> > [...]
> > > On Fri, Sep 26, 2014 at 05:30:40AM +0000, Li.Xiubo at freescale.com wrote:
> > > > Hi Russell,
> > > >
> > > > I'd like to know the status of this patch.
> > > >
> > > > Our Platforms depend on it.
> > >
> > > I'm not applying it.  This option should not be exposed for general
> > > use.  The usage pattern is clear from the existing users - propose
> > > an alternative default value for your platform rather than making it
> > > a user visible tweakable option.
> > >
> >
> > Okay.
> >
> > Something like :
> > ++++++++++
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1ad6fb6..5729a2c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1802,7 +1802,7 @@ source "mm/Kconfig"
> >  config FORCE_MAX_ZONEORDER
> >         int "Maximum zone order" if ARCH_SHMOBILE
> >         range 11 64 if ARCH_SHMOBILE
> > -       default "12" if SOC_AM33XX
> > +       default "12" if SOC_AM33XX || SOC_LS1021A
> >         default "9" if SA1111
> >         default "11"
> >         help
> > ----------
> >
> > Is okay ?
> 
> It's much better than exposing the option, but I'd like this patch to
> appear as a properly submitted change (including a change log which
> provides the reason why this is necessary.)
> 

Okay, I will.

Thanks,

BRs
Xiubo


> Thanks.
> 
> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
