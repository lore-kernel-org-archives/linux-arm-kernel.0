From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 11:00:25 +0000
Subject: [PATCH] Realview: name configuration options after actual
	board names
In-Reply-To: <20110124105427.GH16202@n2100.arm.linux.org.uk>
References: <20110122183038.GA11960@n2100.arm.linux.org.uk>
	<AANLkTimvvNCNsViqs4_=sXB0+HqzdTZkuD5Hc5U18UQc@mail.gmail.com>
	<20110123155549.GF30094@n2100.arm.linux.org.uk>
	<1295865588.14687.36.camel@e102109-lin.cambridge.arm.com>
	<20110124105427.GH16202@n2100.arm.linux.org.uk>
Message-ID: <20110124110025.GI16202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 10:54:27AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 24, 2011 at 10:39:48AM +0000, Catalin Marinas wrote:
> > On Sun, 2011-01-23 at 15:55 +0000, Russell King - ARM Linux wrote:
> > > On Sun, Jan 23, 2011 at 11:02:30AM +0000, Catalin Marinas wrote:
> > > > On Saturday, 22 January 2011, Russell King - ARM Linux
> > > > <linux@arm.linux.org.uk> wrote:
> > > > > I haven't significantly updated the descriptions for the tiles as that
> > > > > is even less clear - as far as I can see on ARMs website, there is no
> > > > > Cortex-A9 tile for Realview EB - only ARM11MPCore, ARM1156T2F-S,
> > > > > ARM1176TZF-S and Cortex-R4F.  So exactly what this 'Multicore Cortex-A9
> > > > > Tile' is..
> > > >
> > > > AFAIK there isn't any official A9 tile for EB. this configuration has
> > > > been used in processor validation and also on the ARMv7 software
> > > > models, that's why we pushed this option. You can remove it if you
> > > > want, we'll probably keep it around in our patches.
> > > 
> > > But otherwise that's an ack for the patch?
> > 
> > It looks fine to me.
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thanks.  I'm going to do a similar thing for Versatile as well, even
> though the names aren't soo confusing.

Ack?

diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index 3f7b5e9..9cdec5a 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -2,17 +2,19 @@ menu "Versatile platform type"
 	depends on ARCH_VERSATILE
 
 config ARCH_VERSATILE_PB
-	bool "Support Versatile/PB platform"
+	bool "Support Versatile Platform Baseboard for ARM926EJ-S"
 	select CPU_ARM926T
 	select MIGHT_HAVE_PCI
 	default y
 	help
-	  Include support for the ARM(R) Versatile/PB platform.
+	  Include support for the ARM(R) Versatile Platform Baseboard
+	  for the ARM926EJ-S.
 
 config MACH_VERSATILE_AB
-	bool "Support Versatile/AB platform"
+	bool "Support Versatile Application Baseboard for ARM926EJ-S"
 	select CPU_ARM926T
 	help
-	  Include support for the ARM(R) Versatile/AP platform.
+	  Include support for the ARM(R) Versatile Application Baseboard
+	  for the ARM926EJ-S.
 
 endmenu
