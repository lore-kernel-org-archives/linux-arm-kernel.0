From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Apr 2018 14:19:52 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.17
Message-ID: <CAK8P3a1RdJskX_+8z8cQ=xeG8BgOPoCCZy125C1qjKWAHecg=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-fixes

for you to fetch changes up to 4ea3f05614926fea280befaa693ba494a500c2c4:

  Merge tag 'arm-soc/for-4.17/devicetree-arm64-fixes' of
https://github.com/Broadcom/stblinux into fixes (2018-04-27 10:21:18
+0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.17

This round of fixes has two larger changes that came in last week:

- A set of a couple of patches all intended to finally turn on
  USB support on various Amlogic SoC based boards. The respective
  driver were not finalized until very late before the merge window
  and the DT portion is the last bit now.
- A defconfig update for gemini that had repeatedly missed the
  cut but that is required to actually boot any real machines
  with the default build.

The rest are the usual small changes:

- A fix for a nasty build regression on the OMAP memory drivers
- A fix for a boot problem on Intel/Altera SocFPGA
- A MAINTAINER file update
- A couple of fixes for issues found by automated testing
  (kernelci, coverity, sparse, ...)
- A few incorrect DT entries are updated to match the hardware

----------------------------------------------------------------
Arnd Bergmann (7):
      Merge tag 'socfpga_defconfig_fix_v4.17' of
git://git.kernel.org/.../dinguyen/linux into fixes
      Merge tag 'arm-soc/for-4.17/drivers-fixes' of
https://github.com/Broadcom/stblinux into fixes
      Merge tag 'juno-fixes-4.17' of
ssh://gitolite.kernel.org/.../sudeep.holla/linux into fixes
      Merge tag 'scmi-fixes-4.17' of
ssh://gitolite.kernel.org/.../sudeep.holla/linux into fixes
      Merge tag 'amlogic-fixes' of
git://git.kernel.org/.../khilman/linux-amlogic into fixes
      Merge tag 'omap-for-v4.17/fixes-signed' of
git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'arm-soc/for-4.17/devicetree-arm64-fixes' of
https://github.com/Broadcom/stblinux into fixes

Colin Ian King (1):
      firmware: arm_scmi: remove redundant null check on array

Dave Gerlach (1):
      ARM: OMAP2+: Fix build when using split object directories

Florian Fainelli (1):
      soc: bcm: raspberrypi-power: Fix use of __packed

Geert Uytterhoeven (1):
      soc: bcm2835: Make !RASPBERRYPI_FIRMWARE dummies return failure

John Garry (1):
      HISI LPC: Add Kconfig MFD_CORE dependency

Linus Walleij (3):
      ARM: dts: Fix NAS4220B pin config
      ARM: s3c24xx: jive: Fix some GPIO names
      ARM: defconfig: Update Gemini defconfig

Martin Blumenstingl (7):
      ARM64: dts: meson-gxl: add USB host support
      ARM64: dts: meson-gxm: add GXM specific USB host configuration
      ARM64: dts: meson-gxl-s905x-p212: enable the USB controller
      ARM64: dts: meson-gx-p23x-q20x: enable the USB controller
      ARM64: dts: meson-gxl-s905x-libretech-cc: enable the USB controller
      ARM64: dts: meson-gxl-nexbox-a95x: enable the USB controller
      ARM64: dts: meson-gxm-khadas-vim2: enable the USB controller

Niklas Cassel (1):
      MAINTAINERS: Remove myself as maintainer

Srinath Mannam (1):
      arm64: dts: correct SATA addresses for Stingray

Sudeep Holla (1):
      arm64: dts: juno: drop unnecessary address-cells and size-cells properties

Thor Thayer (1):
      ARM: socfpga_defconfig: Remove QSPI Sector 4K size force

Tony Lindgren (2):
      ARM: dts: Fix cm2 and prm sizes for omap4
      Merge branch 'omap-for-v4.17/fixes-ti-sysc' into omap-for-v4.17/fixes

 MAINTAINERS                                                  |  2 --
 arch/arm/boot/dts/gemini-nas4220b.dts                        | 28
++++++++++++++--------------
 arch/arm/boot/dts/omap4.dtsi                                 |  8 ++++----
 arch/arm/configs/gemini_defconfig                            | 27
+++++++++++++++++++++++++--
 arch/arm/configs/socfpga_defconfig                           |  1 +
 arch/arm/mach-omap2/Makefile                                 |  6 +-----
 arch/arm/mach-omap2/pm-asm-offsets.c                         |  3 +++
 arch/arm/mach-omap2/sleep33xx.S                              |  1 -
 arch/arm/mach-omap2/sleep43xx.S                              |  1 -
 arch/arm/mach-s3c24xx/mach-jive.c                            |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts  |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   | 61
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        |  4 ++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi                   | 17
+++++++++++++++++
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi                |  2 --
 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi     | 80
++++++++++++++++++++++++++++++++++++++++----------------------------------------
 drivers/bus/Kconfig                                          |  1 +
 drivers/firmware/arm_scmi/clock.c                            |  2 +-
 drivers/memory/emif-asm-offsets.c                            | 72
+-----------------------------------------------------------------------
 drivers/soc/bcm/raspberrypi-power.c                          |  2 +-
 include/linux/ti-emif-sram.h                                 | 75
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h                   |  4 ++--
 25 files changed, 277 insertions(+), 148 deletions(-)
