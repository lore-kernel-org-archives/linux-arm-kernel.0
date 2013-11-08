From: horms@verge.net.au (Simon Horman)
Date: Sat, 9 Nov 2013 08:34:10 +0900
Subject: [PATCH 03/04] ARM: shmobile: Remove legacy KZM9D board code
In-Reply-To: <CANqRtoQdgUqDC6LCkC91G6TD=cgK2ya-M4miPGdhdEPVmc_efQ@mail.gmail.com>
References: <20131106232102.8081.20523.sendpatchset@w520>
 <20131106232129.8081.77546.sendpatchset@w520>
 <20131108084859.GA5213@verge.net.au>
 <CANqRtoQdgUqDC6LCkC91G6TD=cgK2ya-M4miPGdhdEPVmc_efQ@mail.gmail.com>
Message-ID: <20131108233409.GC4017@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 07:03:22PM +0900, Magnus Damm wrote:
> On Fri, Nov 8, 2013 at 5:49 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Nov 07, 2013 at 08:21:29AM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Remove the C and platform device version of KZM9D.
> >>
> >> The DT version of KZM9D board support can now instead
> >> directly be used with SoC specific code in setup-emev2.c.
> >
> > Am I right in thinking that with this change in place we need the following
> > change to the defconfig in order for it to compile.
> >
> > diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
> > index 6c37f4a..002488a 100644
> > --- a/arch/arm/configs/kzm9d_defconfig
> > +++ b/arch/arm/configs/kzm9d_defconfig
> > @@ -13,7 +13,7 @@ CONFIG_SLAB=y
> >  # CONFIG_BLK_DEV_BSG is not set
> >  # CONFIG_IOSCHED_DEADLINE is not set
> >  # CONFIG_IOSCHED_CFQ is not set
> > -CONFIG_ARCH_SHMOBILE=y
> > +CONFIG_ARCH_SHMOBILE_MULTI=y
> >  CONFIG_ARCH_EMEV2=y
> >  CONFIG_MACH_KZM9D=y
> >  CONFIG_MEMORY_START=0x40000000
> >
> >
> > I am holding off on pushing the patches I queued up today until
> > this can be resolved one way or another.
> 
> Oh, right, I guess it doesn't know the link address now when the C
> bits are gone. Sorry about that, I totally forgot about the defconfig.
> 
> At this point I think we should fix up the defconfig to build for
> kzm9d with single platform. So instead of enabling MULTI in the
> kzmd_defconfig, how about this?
> 
> CONFIG_AUTO_ZRELADDR=y
> 
> Also, it seems that the "select USE_OF" went away with the board code
> Kconfig bits. I will send a patch for that right away.

Thanks. USE_OF + CONFIG_AUTO_ZRELADDR appears to work :)
