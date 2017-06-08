From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Thu, 8 Jun 2017 10:13:05 +0200
Subject: [PATCH 00/11] Remove unused omap legacy code
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Message-ID: <20170608081305.fyxu7tvimox4wbjg@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 31, 2017 at 03:51:28PM -0700, Tony Lindgren wrote:
> We can now remove quite a bit of clutter with legacy booting
> gone. Basically anything with of_have_populated_dt() not set
> can now go.

Except for the comment on patch 4 the series is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> Tony Lindgren (11):
>   ARM: OMAP2+: Remove unused legacy code for opp
>   ARM: OMAP2+: Remove unused legacy code for timer
>   ARM: OMAP2+: Remove unused legacy code for PMU
>   ARM: OMAP2+: Remove unused legacy code for device init
>   ARM: OMAP2+: Remove unused legacy code for McBSP
>   ARM: OMAP2+: Remove unused legacy code for io.c
>   ARM: OMAP2+: Remove unused legacy code for DMA
>   ARM: OMAP2+: Remove unused legacy code for PRM
>   ARM: OMAP2+: Remove unused legacy code for interconnects
>   ARM: OMAP2+: Remove unused legacy code for watchdog
>   ARM: OMAP2+: Remove unused legacy code for n8x0
> 
>  arch/arm/mach-omap2/Makefile               |   4 -
>  arch/arm/mach-omap2/board-n8x0.c           |  14 +--
>  arch/arm/mach-omap2/devices.c              | 163 ---------------------------
>  arch/arm/mach-omap2/dma.c                  |  30 +----
>  arch/arm/mach-omap2/io.c                   |  59 +++-------
>  arch/arm/mach-omap2/mcbsp.c                |  70 ------------
>  arch/arm/mach-omap2/omap_device.c          |   5 +-
>  arch/arm/mach-omap2/omap_hwmod.c           |  23 ++--
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   3 +-
>  arch/arm/mach-omap2/opp.c                  | 104 -----------------
>  arch/arm/mach-omap2/opp3xxx_data.c         |  86 ---------------
>  arch/arm/mach-omap2/opp4xxx_data.c         |  79 -------------
>  arch/arm/mach-omap2/pmu.c                  |  97 ----------------
>  arch/arm/mach-omap2/prm3xxx.c              |  17 ++-
>  arch/arm/mach-omap2/prm44xx.c              |  59 ----------
>  arch/arm/mach-omap2/prm_common.c           |   9 +-
>  arch/arm/mach-omap2/timer.c                | 172 ++++-------------------------
>  arch/arm/mach-omap2/wd_timer.c             |  28 -----
>  18 files changed, 63 insertions(+), 959 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/opp.c
>  delete mode 100644 arch/arm/mach-omap2/pmu.c
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170608/2c037f41/attachment-0001.sig>
