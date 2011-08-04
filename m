From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:44:25 -0700
Subject: [PATCH 00/12] Remove timex.h from sub-arch headers
Message-ID: <20110804134425.GA919@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set removes references to LATCH and CLOCK_TICK_RATE in
architectures that still use it for the system timer code.  After
doing so, we kill mach-*/include/mach/timex.h. We need to
currently provide a dummy CLOCK_TICK_RATE for now as jiffies.h 
still uses it to define LATCH which is used in a few places
but there are other patches queued up to remove those too.
Once those are gone, we can kill LATCH and remove CLOCK_TICK_RATE.

Deepak Saxena (12):
  ARM: Remove LATCH reference for time-acorn.c
  ARM: at91: Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: unicore32: Remove depency on LATCH
  ARM: clps711x: Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: h720x:  Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: IXP23xx: Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: IXP4x: Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: ks8695: Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: netx:  Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: pnx4000:  Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: sa1100:  Remove LATCH and CLOCK_TICK_RATE dependency
  ARM: Remove mach-*/include/mach/timex.h

 arch/arm/common/time-acorn.c                  |   15 +++--
 arch/arm/include/asm/timex.h                  |    5 +-
 arch/arm/mach-at91/at91rm9200_time.c          |    6 +-
 arch/arm/mach-at91/include/mach/at91_st.h     |   63 ++++++++++++++++++
 arch/arm/mach-at91/include/mach/timex.h       |   87 -------------------------
 arch/arm/mach-bcmring/include/mach/timex.h    |   25 -------
 arch/arm/mach-clps711x/include/mach/timex.h   |   23 -------
 arch/arm/mach-clps711x/time.c                 |   10 ++-
 arch/arm/mach-cns3xxx/include/mach/timex.h    |   12 ----
 arch/arm/mach-davinci/include/mach/timex.h    |   22 ------
 arch/arm/mach-dove/include/mach/timex.h       |    9 ---
 arch/arm/mach-ebsa110/include/mach/timex.h    |   19 ------
 arch/arm/mach-ep93xx/include/mach/timex.h     |    5 --
 arch/arm/mach-exynos4/include/mach/timex.h    |   29 --------
 arch/arm/mach-footbridge/include/mach/timex.h |   18 -----
 arch/arm/mach-gemini/include/mach/timex.h     |   13 ----
 arch/arm/mach-h720x/common.c                  |    4 +-
 arch/arm/mach-h720x/common.h                  |    3 +
 arch/arm/mach-h720x/cpu-h7201.c               |    2 +-
 arch/arm/mach-h720x/cpu-h7202.c               |    2 +-
 arch/arm/mach-h720x/include/mach/timex.h      |   15 ----
 arch/arm/mach-integrator/include/mach/timex.h |   26 -------
 arch/arm/mach-iop13xx/include/mach/timex.h    |    1 -
 arch/arm/mach-iop32x/include/mach/timex.h     |    6 --
 arch/arm/mach-iop33x/include/mach/timex.h     |    6 --
 arch/arm/mach-ixp2000/include/mach/timex.h    |   13 ----
 arch/arm/mach-ixp23xx/core.c                  |   14 ++--
 arch/arm/mach-ixp23xx/include/mach/timex.h    |    7 --
 arch/arm/mach-ixp4xx/common.c                 |    7 ++-
 arch/arm/mach-ixp4xx/include/mach/timex.h     |   16 -----
 arch/arm/mach-kirkwood/include/mach/timex.h   |   10 ---
 arch/arm/mach-ks8695/include/mach/timex.h     |   21 ------
 arch/arm/mach-ks8695/time.c                   |    4 +-
 arch/arm/mach-lpc32xx/include/mach/timex.h    |   28 --------
 arch/arm/mach-mmp/include/mach/timex.h        |   13 ----
 arch/arm/mach-msm/include/mach/timex.h        |   21 ------
 arch/arm/mach-mv78xx0/include/mach/timex.h    |    9 ---
 arch/arm/mach-mxs/include/mach/timex.h        |   21 ------
 arch/arm/mach-netx/include/mach/timex.h       |   20 ------
 arch/arm/mach-netx/time.c                     |    7 ++-
 arch/arm/mach-nomadik/include/mach/timex.h    |    6 --
 arch/arm/mach-nuc93x/include/mach/timex.h     |   25 -------
 arch/arm/mach-omap1/include/mach/timex.h      |    5 --
 arch/arm/mach-omap2/include/mach/timex.h      |    5 --
 arch/arm/mach-orion5x/include/mach/timex.h    |   11 ---
 arch/arm/mach-pnx4008/include/mach/timex.h    |   19 ------
 arch/arm/mach-pnx4008/time.c                  |   11 ++-
 arch/arm/mach-prima2/include/mach/timex.h     |   14 ----
 arch/arm/mach-pxa/include/mach/timex.h        |   34 ----------
 arch/arm/mach-realview/include/mach/timex.h   |   23 -------
 arch/arm/mach-rpc/include/mach/timex.h        |   17 -----
 arch/arm/mach-s3c2410/include/mach/timex.h    |   24 -------
 arch/arm/mach-s3c64xx/include/mach/timex.h    |   24 -------
 arch/arm/mach-s5p64x0/include/mach/timex.h    |   27 --------
 arch/arm/mach-s5pc100/include/mach/timex.h    |   24 -------
 arch/arm/mach-s5pv210/include/mach/timex.h    |   29 --------
 arch/arm/mach-sa1100/include/mach/timex.h     |   12 ----
 arch/arm/mach-sa1100/time.c                   |    5 +-
 arch/arm/mach-shark/include/mach/timex.h      |    7 --
 arch/arm/mach-shmobile/include/mach/timex.h   |    6 --
 arch/arm/mach-spear3xx/include/mach/timex.h   |   19 ------
 arch/arm/mach-spear6xx/include/mach/timex.h   |   19 ------
 arch/arm/mach-tegra/include/mach/timex.h      |   26 -------
 arch/arm/mach-u300/include/mach/timex.h       |   17 -----
 arch/arm/mach-ux500/include/mach/timex.h      |    6 --
 arch/arm/mach-versatile/include/mach/timex.h  |   23 -------
 arch/arm/mach-vexpress/include/mach/timex.h   |   23 -------
 arch/arm/mach-vt8500/include/mach/timex.h     |   26 -------
 arch/arm/mach-w90x900/include/mach/timex.h    |   25 -------
 arch/arm/mach-zynq/include/mach/timex.h       |   23 -------
 arch/unicore32/include/asm/timex.h            |    2 +
 arch/unicore32/kernel/time.c                  |    2 +-
 72 files changed, 129 insertions(+), 1047 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/timex.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/timex.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/timex.h
 delete mode 100644 arch/arm/mach-dove/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-exynos4/include/mach/timex.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/timex.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/timex.h
 delete mode 100644 arch/arm/mach-h720x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/timex.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/timex.h
 delete mode 100644 arch/arm/mach-msm/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/timex.h
 delete mode 100644 arch/arm/mach-netx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/timex.h
 delete mode 100644 arch/arm/mach-nuc93x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/timex.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/timex.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/timex.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/timex.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/timex.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/timex.h
 delete mode 100644 arch/arm/mach-realview/include/mach/timex.h
 delete mode 100644 arch/arm/mach-rpc/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/timex.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/timex.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/timex.h
 delete mode 100644 arch/arm/mach-shark/include/mach/timex.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/timex.h
 delete mode 100644 arch/arm/mach-u300/include/mach/timex.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/timex.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/timex.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/timex.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/timex.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/timex.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/timex.h

-- 
1.7.4.1
