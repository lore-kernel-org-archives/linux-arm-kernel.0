From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 13:38:23 +0200
Subject: [PATCH v2] ARM: spear: Remove references to PLAT_SPEAR_SINGLE
In-Reply-To: <CAKohpomS5TrG0eU51N-Pu2jE-ZVioNHz-U_7Y-mfFSUU+As-MQ@mail.gmail.com>
References: <1392153676.14317.8.camel@x220> <1409910654.5546.161.camel@x220>
 <CAKohpomS5TrG0eU51N-Pu2jE-ZVioNHz-U_7Y-mfFSUU+As-MQ@mail.gmail.com>
Message-ID: <2863474.Iz36QDfM80@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014 15:24:31 Viresh Kumar wrote:
> On 5 September 2014 15:20, Paul Bolle <pebolle@tiscali.nl> wrote:
> > On Fri, 2014-09-05 at 15:13 +0530, Viresh Kumar wrote:
> >> On Fri, Sep 5, 2014 at 3:09 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> >> >> Ditto for v3.17-rc3 and next-20140904. Could someone please pix this up?
> >>
> >> You need to send it to arm at kernel.org..
> >
> > Will do, no problem. But why actually? (Note that MAINTAINERS is silent
> > on arm at kernel.org. Maybe that address is documented elsewhere.)
> 
> Don't know where it is documented.
> 
> @Arnd: ??

We have avoided documenting it so far, to avoid getting spammed with trivial
patches that should get picked up by the subarch maintainers instead.

I've applied this patch to the next/fixes-non-critical branch now, with minor
fixup for a conflict that has come in. See below for the final version.

	Arnd

---
commit 3b0b8ec99aadea710f3dece74c95523463c0087a
Author: Paul Bolle <pebolle@tiscali.nl>
Date:   Tue Apr 15 10:26:47 2014 +0200

    ARM: spear: Remove references to PLAT_SPEAR_SINGLE
    
    The Kconfig symbol PLAT_SPEAR_SINGLE briefly appeared during the v3.10
    development cycle. It was removed in a merge commit before v3.10. A few
    references to it were left in the tree, probably because they didn't
    generate merge conflicts. Whatever it was, they're useless now and can
    safely be removed.
    
    Reported-by: Martin Walch <walch.martin@web.de>
    Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
    Reviewed-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
    Cc: Rajeev Kumar <rajeev_kumar@mentor.com>
    Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index 6fd4dc88160b..b6f4bda273b3 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -4,7 +4,6 @@
 
 menuconfig PLAT_SPEAR
 	bool "ST SPEAr Family" if ARCH_MULTI_V7 || ARCH_MULTI_V5
-	default PLAT_SPEAR_SINGLE
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select CLKSRC_MMIO
@@ -13,7 +12,7 @@ if PLAT_SPEAR
 
 config ARCH_SPEAR13XX
 	bool "ST SPEAr13xx"
-	depends on ARCH_MULTI_V7 || PLAT_SPEAR_SINGLE
+	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select GPIO_SPEAR_SPICS
 	select HAVE_ARM_SCU if SMP
@@ -44,7 +43,7 @@ endif #ARCH_SPEAR13XX
 
 config ARCH_SPEAR3XX
 	bool "ST SPEAr3xx"
-	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
+	depends on ARCH_MULTI_V5
 	depends on !ARCH_SPEAR13XX
 	select ARM_VIC
 	select PINCTRL
@@ -75,7 +74,7 @@ endif
 
 config ARCH_SPEAR6XX
 	bool "ST SPEAr6XX"
-	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
+	depends on ARCH_MULTI_V5
 	depends on !ARCH_SPEAR13XX
 	select ARM_VIC
 	help
@@ -88,7 +87,7 @@ config MACH_SPEAR600
 	  Supports ST SPEAr600 boards configured via the device-tree
 
 config ARCH_SPEAR_AUTO
-	def_bool PLAT_SPEAR_SINGLE
+	bool
 	depends on !ARCH_SPEAR13XX && !ARCH_SPEAR6XX
 	select ARCH_SPEAR3XX
 
