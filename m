From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 09:20:14 +0200
Subject: [RFC PATCHv2 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA  Cyclone 5 HW
In-Reply-To: <50049916.3080509@gmail.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <1342113976-27140-3-git-send-email-dinguyen@altera.com>
 <50049916.3080509@gmail.com>
Message-ID: <20120717092014.53392f77@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 16 Jul 2012 17:43:34 -0500,
Rob Herring <robherring2@gmail.com> a ?crit :

> > diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> > new file mode 100644
> > index 0000000..133fc89
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/Kconfig
> > @@ -0,0 +1,7 @@
> > +config MACH_SOCFPGA_CYCLONE5
> > +       bool "SOCFPGA Cyclone5 platform"
> > +       select COMMON_CLK
> > +       select HAVE_SMP
> > +       select PLAT_SOCFPGA_ETH
> > +       help
> > +         Include support for the Altera(R) Cyclone5 development platform.
> 
> You don't need a config option for a machine with DT.

Ah, interesting, I was precisely going to send an e-mail today about
this, because we currently have different cases in tree:

 * In mach-tegra/Kconfig, there is one Kconfig option per-board, and
   then mach-tegra/Makefile.boot contains lines like
   dtb-$(CONFIG_MACH_<board>) += <board>.dtb. So there is one Kconfig
   option per-board, and a .dtb generation per-board.

 * In mach-at91/Kconfig, there is only one Kconfig option to support
   all DT-based platforms (CONFIG_MACH_AT91SAM_DT), and
   mach-at91/Makefile.boot generates the .dtb files for all boards as
   soon as CONFIG_MACH_AT91SAM_DT is enabled. So very different
   strategy from mach-tegra.

 * In mach-mxs/Kconfig, there is only one Kconfig option to support all
   DT-based platforms (MACH_MXS_DT), but the mach-mxs/Makefile.boot
   does not have any dtb-... += line.

Which approach is the correct one? My feeling would be that the
mach-at91 approach is the right one, because it doesn't make sense to
have one Kconfig option per board when we use the device tree. Is this
correct?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
