From: rnayak@ti.com (Nayak, Rajendra)
Date: Fri, 4 Dec 2009 15:35:21 +0530
Subject: [PATCH 0/8] OMAP clock: convert static definitions in header
	files to	C files
In-Reply-To: <20091203095830.1203.76290.stgit@localhost.localdomain>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ABC2908@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Some patches in this series seem to be missing, specifically 5/8 and 6/8.
Can you please re-post?

regards,
Rajendra 

>-----Original Message-----
From: linux-omap-owner@vger.kernel.org 
>[mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Paul Walmsley
>Sent: Thursday, December 03, 2009 3:37 PM
>To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
>Subject: [PATCH 0/8] OMAP clock: convert static definitions in 
>header files to C files
>
>The OMAP clock code has traditionally defined its clock nodes
>statically in header files (e.g., mach-omap1/clock.h).  This violates
>the general guideline that including a header file should be
>side-effect free, or at least as side-effect free as possible.  This
>series moves all of the statically-allocated data from header files
>into C files that are linked into kernels.  It moves OPP data (or at
>least the proto-OPP data in OMAP1 and OMAP2xxx) into separate files.
>It also resolves all of the checkpatch errors that appear as a result
>of the move.
>
>This series has been boot-tested on OMAP1 (on a 5912 OSK), 
>OMAP2 (on N800 and
>2430 SDP), and OMAP3 (BeagleBoard).  
>
>This series was prompted by a comment from Russell King
><rmk+kernel@arm.linux.org.uk>, who suggested the basic layout 
>that these
>patches implement.
>
>
>- Paul
>
>---
>
>size:
>   text	   data	    bss	    dec	    hex	filename
>3582959	 199264	 107176	3889399	 3b58f7	vmlinux.beagle.orig
>3583063	 199264	 107176	3889503	 3b595f	vmlinux.beagle
>
>Paul Walmsley (8):
>      OMAP1/2/3 clock: remove paranoid checks in preparation 
>for clock{,2xxx,3xxx}_data.c
>      OMAP2 clock: APLL code shouldn't rely on static clocks 
>in its local namespace
>      OMAP2/3: move SDRC macros to mach-omap2/sdrc.h
>      OMAP2xxx clock: remove implicit dependency between rate 
>CPU flag and clkdev_omap CPU flag
>      OMAP3 clock: convert clock34xx.h to clock34xx_data.c
>      OMAP2 clock: convert clock24xx.h to clock2xxx_data.c, opp2xxx*
>      OMAP1 clock: convert test in disable_unused() to use 
>ENABLE_ON_INIT
>      OMAP1 clock: convert mach-omap1/clock.h to 
>mach-omap1/clock_data.c
>
>
> arch/arm/mach-omap1/Makefile                  |    3 
> arch/arm/mach-omap1/clock.c                   |  415 ---
> arch/arm/mach-omap1/clock.h                   |  652 -----
> arch/arm/mach-omap1/clock_data.c              |  443 +++-
> arch/arm/mach-omap1/io.c                      |    3 
> arch/arm/mach-omap1/opp.h                     |   28 
> arch/arm/mach-omap1/opp_data.c                |   59 
> arch/arm/mach-omap2/Makefile                  |    8 
> arch/arm/mach-omap2/clock.h                   |   30 
> arch/arm/mach-omap2/clock24xx.c               |  805 -------
> arch/arm/mach-omap2/clock2xxx.c               |  564 +++++
> arch/arm/mach-omap2/clock2xxx.h               |   44 
> arch/arm/mach-omap2/clock2xxx_data.c          |  844 ++-----
> arch/arm/mach-omap2/clock34xx.c               |  471 ----
> arch/arm/mach-omap2/clock34xx.h               | 3013 
>-------------------------
> arch/arm/mach-omap2/clock34xx_data.c          |  364 +++
> arch/arm/mach-omap2/clock_common_data.c       |   39 
> arch/arm/mach-omap2/opp2420_data.c            |  126 +
> arch/arm/mach-omap2/opp2430_data.c            |  133 +
> arch/arm/mach-omap2/opp2xxx.h                 |  424 ++++
> arch/arm/mach-omap2/sdrc.h                    |   19 
> arch/arm/plat-omap/include/plat/clkdev_omap.h |   41 
> arch/arm/plat-omap/include/plat/clock.h       |    2 
> 23 files changed, 2592 insertions(+), 5938 deletions(-)
> copy arch/arm/mach-omap1/{clock.h => clock_data.c} (58%)
> create mode 100644 arch/arm/mach-omap1/opp.h
> create mode 100644 arch/arm/mach-omap1/opp_data.c
> delete mode 100644 arch/arm/mach-omap2/clock24xx.c
> create mode 100644 arch/arm/mach-omap2/clock2xxx.c
> create mode 100644 arch/arm/mach-omap2/clock2xxx.h
> rename arch/arm/mach-omap2/{clock24xx.h => clock2xxx_data.c} (73%)
> copy arch/arm/mach-omap2/{clock34xx.h => clock34xx_data.c} (86%)
> create mode 100644 arch/arm/mach-omap2/clock_common_data.c
> create mode 100644 arch/arm/mach-omap2/opp2420_data.c
> create mode 100644 arch/arm/mach-omap2/opp2430_data.c
> create mode 100644 arch/arm/mach-omap2/opp2xxx.h
> create mode 100644 arch/arm/plat-omap/include/plat/clkdev_omap.h
>
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-omap" in
>the body of a message to majordomo at vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
