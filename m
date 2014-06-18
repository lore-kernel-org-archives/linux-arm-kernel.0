From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jun 2014 17:16:55 +0200
Subject: [PATCH 03/14] ARM: keystone requires ARM_PATCH_PHYS_VIRT
In-Reply-To: <CAL_JsqLNH-qL49EnaSbHQkhBpNvEWTJ1tExT6qtiyYzyAhcPLg@mail.gmail.com>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
 <1402675276-538682-4-git-send-email-arnd@arndb.de>
 <CAL_JsqLNH-qL49EnaSbHQkhBpNvEWTJ1tExT6qtiyYzyAhcPLg@mail.gmail.com>
Message-ID: <21215705.gcNUAhls8f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 June 2014 09:39:57 Rob Herring wrote:
> On Fri, Jun 13, 2014 at 11:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The dynamic relocation that the keystone platform performs
> > only works if we can pick the phys offset at boot time. It's
> > possible that there is another solution for this, but this
> > is the easiest workaround. Kernels with ARM_PATCH_PHYS_VIRT
> > are not portable across platforms, and I see no reason why
> > anyone would run a kernel without ARM_PATCH_PHYS_VIRT on
> > keystone.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-keystone/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
> > index f50bc93..98a156a 100644
> > --- a/arch/arm/mach-keystone/Kconfig
> > +++ b/arch/arm/mach-keystone/Kconfig
> > @@ -1,6 +1,7 @@
> >  config ARCH_KEYSTONE
> >         bool "Texas Instruments Keystone Devices"
> >         depends on ARCH_MULTI_V7
> > +       depends on ARM_PATCH_PHYS_VIRT
> 
> Why is this needed when multi-platform already selects this?
> 

I have a patch to make ARM_PATCH_PHYS_VIRT optional for multi-platform,
which I plan to post at some point in the next weeks. This will let
us enable NOMMU builds and other things in platforms that are
converted to multiplatform (at the obvious expense of losing generality
for that particular build). Most other platforms can work with or without
ARM_PATCH_PHYS_VIRT, but keystone lost that ability.

	Arnd
