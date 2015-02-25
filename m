From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Feb 2015 11:11:08 +0000
Subject: [PATCH 1/3] arm64: mediatek: Add config option for mt8173.
In-Reply-To: <5948977.qlhSVy9R5i@wuerfel>
References: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
 <1422342836-27689-2-git-send-email-hongzhou.yang@mediatek.com>
 <1424855242.7845.9.camel@mtksdaap41> <5948977.qlhSVy9R5i@wuerfel>
Message-ID: <20150225111107.GA29206@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 11:51:57AM +0100, Arnd Bergmann wrote:
> On Wednesday 25 February 2015 17:07:22 Yingjoe Chen wrote:
> > On Tue, 2015-01-27 at 15:13 +0800, Hongzhou Yang wrote:
> > > From: Hongzhou Yang <hongzhou.yang@mediatek.com>
> > > 
> > > The upcoming MTK pinctrl driver have a big pin table for each SoC,
> > > and we don't want to bloat the kernel binary if we don't need it.
> > > Add config options so we can build for one SoC only.
> > > 
> > > Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> > > ---
> > >  arch/arm64/Kconfig | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index e627ead..6213dac 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -151,9 +151,15 @@ menu "Platform selection"
> > >  config ARCH_MEDIATEK
> > >       bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
> > >       select ARM_GIC
> > > +     select PINCTRL
> > >       help
> > >         Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
> > >  
> > > +config MACH_MT8173
> > > +     bool "Mediatek 8173 Soc Supprt"
> > > +     depends on ARCH_MEDIATEK
> > > +     default y
> > > +
> > >  config ARCH_SEATTLE
> > >       bool "AMD Seattle SoC Family"
> > >       help
> > 
> > Hi Arnd/Matthias,
> > 
> > Any comments on this patch?
> 
> Hi Joe,
> 
> Actually I just commented on a similar patch from Samsung the other
> day, and I think we should make a more general decision about these:
> 
> I would rather see only one Kconfig option per SoC family and use
> ARCH_MEDIATEK without any MACH_* options. We can have other options
> for e.g. networking chips from Mediatek that are not closely related
> but I would group all the phone and tablet chips under one option
> here. Same for the other vendors of course.

I agree.

-- 
Catalin
