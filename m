From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 10:15:01 -0600
Subject: [PATCH 0/6] highbank fixes for 3.8
Message-ID: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series fixes secondary boot/hotplug, some boot warnings and
suspend/resume for highbank. Arguably, suspend fixes are 3.9 material,
but I'm including it here as the same fix needed for suspend/resume is
needed to fix secondary core boot on 3.8.

Also, the Nico's gic change (ARM: gic: use a private mapping for CPU target
interfaces) breaks QEMU which does not initialize the cpu target registers
correctly.

Rob

Rob Herring (6):
  ARM: dts: add device_type prop to cpu nodes on Calxeda platforms
  ARM: dts: fix highbank cpu mpidr values
  ARM: highbank: fix typos with hignbank in power request functions
  ARM: highbank: fix secondary boot and hotplug
  ARM: highbank: add a power request clear
  ARM: highbank: save and restore L2 cache and GIC on suspend

 arch/arm/boot/dts/ecx-2000.dts    |    4 ++++
 arch/arm/boot/dts/highbank.dts    |   20 ++++++++++++--------
 arch/arm/mach-highbank/highbank.c |    2 +-
 arch/arm/mach-highbank/hotplug.c  |    2 +-
 arch/arm/mach-highbank/platsmp.c  |   12 +-----------
 arch/arm/mach-highbank/pm.c       |   19 ++++++++++++++++++-
 arch/arm/mach-highbank/sysregs.h  |   23 +++++++++++++++++++----
 arch/arm/mach-highbank/system.c   |    4 ++--
 8 files changed, 58 insertions(+), 28 deletions(-)

-- 
1.7.10.4
