From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 26 Aug 2016 19:12:48 +0800
Subject: [PATCH 0/3] Add SMP support for i.MX7D
Message-ID: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX7D has 2 Cortex-A7 ARM cores, and it has a different GPC design
than i.MX6, so this patch set adds a new GPCV2 driver for i.MX7D,
and also adds runtime check in SMP code to support both Cortex-A9
and Cortex-A7 ARM cores.

With this patch set, i.MX7D can boot up SMP kernel with 2 CPUs.

Anson Huang (3):
  ARM: dts: imx7: support SMP boot up
  ARM: imx: add gpcv2 support
  ARM: imx: add SMP support for i.MX7D

 arch/arm/boot/dts/imx7s.dtsi   |  8 +++++
 arch/arm/mach-imx/Kconfig      |  4 +++
 arch/arm/mach-imx/Makefile     |  1 +
 arch/arm/mach-imx/common.h     |  2 ++
 arch/arm/mach-imx/gpcv2.c      | 66 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/headsmp.S    | 11 +++++++
 arch/arm/mach-imx/mach-imx7d.c |  2 ++
 arch/arm/mach-imx/platsmp.c    | 23 ++++++++++++++-
 arch/arm/mach-imx/src.c        | 38 +++++++++++++++++++-----
 9 files changed, 146 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-imx/gpcv2.c

-- 
1.9.1
