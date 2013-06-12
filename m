From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 12 Jun 2013 17:25:14 -0400
Subject: [PATCH v2 0/3] ARM: Add minimal support for TI Keystone SOCs
Message-ID: <1371072317-15030-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

Here is the refreshed v2 version of the Keystone SOC support series
after fixing all the discussed comments. I also posted multi_v7_defconfig
bits in a seperate patch which lets Keystone boot with it. Its a very
small and indepedent series, so if you are happy with this version, I
would like to get it queued for upcoming 3.11 merge window.

Series adds minimal support to Texas Instruments Keystone 2 based
SOCs. Basic SOC code and simple dt file describing SOC which is enough
to get the device booting till shell against mainline v3.10-rcx release.

Texas Instruments Keystone family of multi-core devices are
based on ARM Cortex A15. The TCI66xxK2H Communications Infrastructure
Keystone SoCs are member of the C66x family based on TI's new
KeyStone 2 multi-core SoC Architecture designed specifically for
high performance wireless and networking infrastructure applications.

The SOCs contains many subsystems like Cortex A15 ARM CorePacs,
C66XX DSP CorePacs, MSMC memory controller, Tera Net bus,
IP Network, Navigator, Hyperlink, 1G/10G Ethernet, Radio layers
and queue based communication systems.

The patchset is available on my git tree and details are end of the
email [1]

The Keystone Linux port has been used internal and externally for quite some
time and its based on slightly older kernels. I need to specially mention
about Cyril Chemparathy who was integral part of many of the development
for Keystone linux port along with Murali, Vitaly and rest of the team.
We would like to take all the internal linux keystone work to mainline
and this is the first step to get that process started.

There is public documentation available for these SOCs. Here is one of
the link [2]

Santosh Shilimkar (3):
  ARM: dts: keystone: Add minimal Keystone SOC device tree data
  ARM: keystone: Add minimal TI Keystone platform support
  ARM: keystone: Enable SMP support on Keystone machines

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: arm at kernel.org

 .../devicetree/bindings/arm/keystone/keystone.txt  |   10 ++
 arch/arm/Kconfig                                   |    3 +
 arch/arm/Kconfig.debug                             |   16 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/keystone.dts                     |  109 ++++++++++++++
 arch/arm/configs/keystone_defconfig                |  157 ++++++++++++++++++++
 arch/arm/include/debug/keystone.S                  |   43 ++++++
 arch/arm/mach-keystone/Kconfig                     |   15 ++
 arch/arm/mach-keystone/Makefile                    |    2 +
 arch/arm/mach-keystone/Makefile.boot               |    1 +
 arch/arm/mach-keystone/keystone.c                  |   77 ++++++++++
 arch/arm/mach-keystone/keystone.h                  |   17 +++
 arch/arm/mach-keystone/platsmp.c                   |   52 +++++++
 13 files changed, 503 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/keystone.txt
 create mode 100644 arch/arm/boot/dts/keystone.dts
 create mode 100644 arch/arm/configs/keystone_defconfig
 create mode 100644 arch/arm/include/debug/keystone.S
 create mode 100644 arch/arm/mach-keystone/Kconfig
 create mode 100644 arch/arm/mach-keystone/Makefile
 create mode 100644 arch/arm/mach-keystone/Makefile.boot
 create mode 100644 arch/arm/mach-keystone/keystone.c
 create mode 100644 arch/arm/mach-keystone/keystone.h
 create mode 100644 arch/arm/mach-keystone/platsmp.c

Regards,
Santosh

[1] Git tree details
 git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
 keystone/dt
 keystone/soc
 keystone/master --> 'soc + dt'

[2] Device specs
 http://www.ti.com/product/tci6636k2h
-- 
1.7.9.5
