From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 21 Oct 2016 10:58:46 +0200
Subject: [PATCH v2 0/2] ARM: oxnas: Add SMP support for OX820
Message-ID: <20161021085848.1754-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the SMP feature of the Oxford Semiconductor OX820 SoC,
add the necessary code to handle the wake-up, hotplug and cpu entry.

The OX820 has an ARM11MPCORE cluster with 2 cores and has proper hardware
support for secondary core booting.

Changes since v1 at http://lkml.kernel.org/r/20161017084303.20078-1-narmstrong at baylibre.com
 - Remove useless holding pen loops and spinlock in boot_secondary

Neil Armstrong (2):
  ARM: oxnas: Add OX820 SMP support
  ARM: oxnas: Add OX820 config and makefile entry

 arch/arm/Makefile             |   1 +
 arch/arm/mach-oxnas/Kconfig   |  30 ++++++++----
 arch/arm/mach-oxnas/Makefile  |   2 +
 arch/arm/mach-oxnas/headsmp.S |  28 +++++++++++
 arch/arm/mach-oxnas/hotplug.c | 111 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-oxnas/platsmp.c | 104 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 267 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-oxnas/Makefile
 create mode 100644 arch/arm/mach-oxnas/headsmp.S
 create mode 100644 arch/arm/mach-oxnas/hotplug.c
 create mode 100644 arch/arm/mach-oxnas/platsmp.c

-- 
2.7.0
