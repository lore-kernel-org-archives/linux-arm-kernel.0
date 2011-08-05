From: bs14@csr.com (Barry Song)
Date: Thu, 4 Aug 2011 19:54:46 -0700
Subject: [RFC PATCH 0/2] ARM: CSR: add rtciobrg and PM sleep entry
Message-ID: <1312512888-25070-1-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rtciobrg is the bridge between the RTC clock domain and the CPU interface
clock domain. ARM access the register of SYSRTC, GPSRTC and PWRC through
this module.
Then PM controller depends on rtciobrg, we access PM through rtciobrg.

Rongjun Ying (1):
  ARM: CSR: add PM sleep entry for SiRFprimaII

Zhiwu Song (1):
  ARM: CSR: add rtc i/o bridge interface for SiRFprimaII

 arch/arm/mach-prima2/Makefile        |    2 +
 arch/arm/mach-prima2/common.h        |    1 +
 arch/arm/mach-prima2/l2x0.c          |   34 +++--
 arch/arm/mach-prima2/pm.c            |  139 ++++++++++++++++++++
 arch/arm/mach-prima2/pm.h            |   32 +++++
 arch/arm/mach-prima2/rtciobrg.c      |  118 +++++++++++++++++
 arch/arm/mach-prima2/sleep.S         |  238 ++++++++++++++++++++++++++++++++++
 include/linux/rtc/sirfsoc_rtciobrg.h |   20 +++
 8 files changed, 570 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/mach-prima2/pm.c
 create mode 100644 arch/arm/mach-prima2/pm.h
 create mode 100644 arch/arm/mach-prima2/rtciobrg.c
 create mode 100644 arch/arm/mach-prima2/sleep.S
 create mode 100644 include/linux/rtc/sirfsoc_rtciobrg.h



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
