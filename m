From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 16 Jun 2014 13:49:47 +0200
Subject: [PATCH v2] ARM: spear: Remove references to PLAT_SPEAR_SINGLE
In-Reply-To: <534CFB45.9070704@st.com>
References: <1392153676.14317.8.camel@x220> <1397550407.1985.12.camel@x220>
 <534CFB45.9070704@st.com>
Message-ID: <1402919387.30599.4.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-04-15 at 14:56 +0530, Rajeev kumar wrote:
> On 4/15/2014 1:56 PM, Paul Bolle wrote:
> > The Kconfig symbol PLAT_SPEAR_SINGLE briefly appeared during the v3.10
> > development cycle. It was removed in a merge commit before v3.10. A few
> > references to it were left in the tree, probably because they didn't
> > generate merge conflicts. Whatever it was, they're useless now and can
> > safely be removed.
> >
> > Reported-by: Martin Walch <walch.martin@web.de>
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > ---
> > 0) First version was broken: it left config ARCH_SPEAR_AUTO without its
> > bool type. This version is done on top of v3.15-rc1.
> >
> > 1) Still untested.
> >
> >   arch/arm/mach-spear/Kconfig | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
> > index 0786249b2832..bc8a11c53377 100644
> > --- a/arch/arm/mach-spear/Kconfig
> > +++ b/arch/arm/mach-spear/Kconfig
> > @@ -4,7 +4,6 @@
> >
> >   menuconfig PLAT_SPEAR
> >   	bool "ST SPEAr Family" if ARCH_MULTI_V7 || ARCH_MULTI_V5
> > -	default PLAT_SPEAR_SINGLE
> >   	select ARCH_REQUIRE_GPIOLIB
> >   	select ARM_AMBA
> >   	select CLKSRC_MMIO
> > @@ -13,7 +12,7 @@ if PLAT_SPEAR
> >
> >   config ARCH_SPEAR13XX
> >   	bool "ST SPEAr13xx"
> > -	depends on ARCH_MULTI_V7 || PLAT_SPEAR_SINGLE
> > +	depends on ARCH_MULTI_V7
> >   	select ARCH_HAS_CPUFREQ
> >   	select ARM_GIC
> >   	select GPIO_SPEAR_SPICS
> > @@ -41,7 +40,7 @@ endif #ARCH_SPEAR13XX
> >
> >   config ARCH_SPEAR3XX
> >   	bool "ST SPEAr3xx"
> > -	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
> > +	depends on ARCH_MULTI_V5
> >   	depends on !ARCH_SPEAR13XX
> >   	select ARM_VIC
> >   	select PINCTRL
> > @@ -72,7 +71,7 @@ endif
> >
> >   config ARCH_SPEAR6XX
> >   	bool "ST SPEAr6XX"
> > -	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
> > +	depends on ARCH_MULTI_V5
> >   	depends on !ARCH_SPEAR13XX
> >   	select ARM_VIC
> >   	help
> > @@ -85,7 +84,7 @@ config MACH_SPEAR600
> >   	  Supports ST SPEAr600 boards configured via the device-tree
> >
> >   config ARCH_SPEAR_AUTO
> > -	def_bool PLAT_SPEAR_SINGLE
> > +	bool
> >   	depends on !ARCH_SPEAR13XX && !ARCH_SPEAR6XX
> >   	select ARCH_SPEAR3XX
> >
> >
> 
> 
> Reviewed-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>

Thanks!

This can still be seen in v3.16-rc1 and in today's linux-next (ie,
next-20140616). Is this trivial patch queued somewhere?


Paul Bolle
