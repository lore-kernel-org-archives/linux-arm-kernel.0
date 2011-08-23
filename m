From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 22 Aug 2011 23:15:48 -0700
Subject: [PATCH v2 0/4] ARM: CSR: add rtciobrg and PM support
Message-ID: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtciobrg is the bridge between the RTC clock domain and the CPU interface
clock domain. ARM access the register of SYSRTC, GPSRTC and PWRC through
this module.
Then PM controller depends on rtciobrg, we access PM through rtciobrg.

Barry Song (1):
  ARM: L2X0: move l2x0_init out of .init section

Rongjun Ying (2):
  ARM: CSR: add PM sleep entry for SiRFprimaII
  ARM: CSR: add PM suspend/resume entries for SiRFprimaII L2 cache

Zhiwu Song (1):
  ARM: CSR: add rtc i/o bridge interface for SiRFprimaII

 arch/arm/boot/dts/prima2-cb.dts            |    2 +-
 arch/arm/include/asm/hardware/cache-l2x0.h |    2 +-
 arch/arm/mach-prima2/Makefile              |    1 +
 arch/arm/mach-prima2/l2x0.c                |   82 +++++++++++----
 arch/arm/mach-prima2/pm.c                  |  158 ++++++++++++++++++++++++++++
 arch/arm/mach-prima2/pm.h                  |   31 ++++++
 arch/arm/mach-prima2/rtciobrg.c            |  136 ++++++++++++++++++++++++
 arch/arm/mach-prima2/sleep.S               |   61 +++++++++++
 arch/arm/mm/cache-l2x0.c                   |    2 +-
 include/linux/rtc/sirfsoc_rtciobrg.h       |   18 +++
 10 files changed, 468 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mach-prima2/pm.c
 create mode 100644 arch/arm/mach-prima2/pm.h
 create mode 100644 arch/arm/mach-prima2/rtciobrg.c
 create mode 100644 arch/arm/mach-prima2/sleep.S
 create mode 100644 include/linux/rtc/sirfsoc_rtciobrg.h



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
