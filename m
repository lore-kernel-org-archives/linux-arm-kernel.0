From: markus.mayer@linaro.org (Markus Mayer)
Date: Wed, 24 Jul 2013 16:35:21 -0700
Subject: [PATCH v2 0/2] ARM: bcm281xx: Board specific reboot code
Message-ID: <1374708923-11956-1-git-send-email-markus.mayer@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a slightly reworked version of the reboot code posted earlier.
It has been rebased on 3.11-rc1.

The original patches are here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/180814.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/180817.html

Changes since v1 include:
  - change vendor prefix for watchdog from "bcm," to "brcm,"
  - change bcm_kona_restart() to use enum reboot_mode as first parameter
  - error checking to catch unmapped watchdog or missing DT entry
  - removal of unused #define
  - formatting changes
  - additional comments in code


Markus Mayer (2):
  ARM: bcm281xx: Board specific reboot code
  ARM: bcm281xx: DT changes for reboot code

 .../devicetree/bindings/arm/bcm/bcm,kona-wdt.txt   |   15 +++++
 arch/arm/boot/dts/bcm11351.dtsi                    |    7 ++-
 arch/arm/mach-bcm/Makefile                         |    4 +-
 arch/arm/mach-bcm/board_bcm.c                      |   20 +++++-
 arch/arm/mach-bcm/kona.c                           |   65 ++++++++++++++++++++
 arch/arm/mach-bcm/kona.h                           |   17 +++++
 6 files changed, 122 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm,kona-wdt.txt
 create mode 100644 arch/arm/mach-bcm/kona.c
 create mode 100644 arch/arm/mach-bcm/kona.h

-- 
1.7.9.5
