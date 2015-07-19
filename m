From: olof@lixom.net (Olof Johansson)
Date: Sat, 18 Jul 2015 21:16:53 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20150719041653.GA15063@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 3eae03daa538303e0d28f56412c6c51f6452e493:

  Merge tag 'pxa-fixes-v4.2-rc2' of https://github.com/rjarzmik/linux into fixesD (2015-07-18 21:06:10 -0700)

----------------------------------------------------------------
ARM: SoC fixes for v4.2

By far most of the fixes here are updates to DTS files to deal with some
mostly minor bugs.

There's also a fix to deal with non-PM kernel configs on i.MX, a
regression fix for ethernet on PXA platforms and a dependency fix for OMAP.

----------------------------------------------------------------
Adam YH Lee (3):
      ARM: dts: omap3: overo: Update LCD panel names
      ARM: dts: configure regulators for Gumstix Pepper
      ARM: dts: Correct audio input route & set mic bias for am335x-pepper

Arun Bharadwaj (1):
      ARM: dts: Fix frequency scaling on Gumstix Pepper

Baruch Siach (1):
      MAINTAINERS: digicolor: add dts files

Chris Zhong (1):
      ARM: dts: cros-ec-keyboard: Add support for some Japanese keys

Dave Gerlach (1):
      ARM: OMAP2+: Add HAVE_ARM_SCU for AM43XX

Fabio Estevam (1):
      ARM: dts: imx27: Adjust the GPT compatible string

Linus Walleij (2):
      ARM: ux500: define serial port aliases
      ARM: ux500: fix MMC/SD card regression

Lucas Stach (1):
      ARM: imx6: gpc: always enable PU domain if CONFIG_PM is not set

Murali Karicheri (2):
      ARM: keystone: dts: fix dt bindings for PCIe
      ARM: keystone: dts: rename pcie nodes to help override status

Olof Johansson (5):
      Merge tag 'socfpga_fixes_for_v4.2-rc1' of git://git.kernel.org/.../dinguyen/linux into fixes
      Merge tag 'imx-fixes-4.2' of git://git.kernel.org/.../shawnguo/linux into fixes
      Merge tag 'omap-for-v4.2/fixes-rc2-v2' of git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge tag 'keystone-dts-fixes' of git://git.kernel.org/.../ssantosh/linux-keystone into fixes
      Merge tag 'pxa-fixes-v4.2-rc2' of https://github.com/rjarzmik/linux into fixesD

Philipp Zabel (1):
      ARM: dts: imx53-qsb: fix TVE entry

Robert Jarzmik (1):
      ARM: pxa: fix dm9000 platform data regression

Stefan Wahren (1):
      ARM: dts: mx23: fix iio-hwmon support

Suman Anna (2):
      ARM: dts: OMAP4: Add #iommu-cells property to IOMMUs
      ARM: dts: OMAP5: Add #iommu-cells property to IOMMUs

Walter Lozano (2):
      ARM: socfpga: dts: Fix adxl34x formating and compatible string
      ARM: socfpga: dts: Fix entries order

 MAINTAINERS                                     |  1 +
 arch/arm/boot/dts/am335x-pepper.dts             | 16 ++++++++++++---
 arch/arm/boot/dts/cros-ec-keyboard.dtsi         |  4 ++++
 arch/arm/boot/dts/imx23.dtsi                    |  1 +
 arch/arm/boot/dts/imx27.dtsi                    | 12 +++++------
 arch/arm/boot/dts/imx53-qsb-common.dtsi         |  5 +++--
 arch/arm/boot/dts/k2e.dtsi                      |  3 ++-
 arch/arm/boot/dts/keystone.dtsi                 |  3 ++-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi |  2 +-
 arch/arm/boot/dts/omap4.dtsi                    |  2 ++
 arch/arm/boot/dts/omap5.dtsi                    |  2 ++
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   | 26 ++++++++++++------------
 arch/arm/boot/dts/ste-ccu8540.dts               |  7 +++++++
 arch/arm/boot/dts/ste-ccu9540.dts               |  7 +++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi               |  6 +++---
 arch/arm/boot/dts/ste-href.dtsi                 |  2 +-
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts      |  7 +++++++
 arch/arm/boot/dts/ste-hrefprev60-tvk.dts        |  7 +++++++
 arch/arm/boot/dts/ste-hrefprev60.dtsi           |  5 +++++
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts     |  7 +++++++
 arch/arm/boot/dts/ste-hrefv60plus-tvk.dts       |  7 +++++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi          | 25 +++++++++++++++++++++--
 arch/arm/boot/dts/ste-snowball.dts              | 25 +++++++++++++++++++++--
 arch/arm/mach-imx/gpc.c                         | 27 ++++++-------------------
 arch/arm/mach-omap2/Kconfig                     |  1 +
 arch/arm/mach-pxa/capc7117.c                    |  3 +++
 arch/arm/mach-pxa/cm-x2xx.c                     |  3 +++
 arch/arm/mach-pxa/cm-x300.c                     |  2 ++
 arch/arm/mach-pxa/colibri-pxa270.c              |  3 +++
 arch/arm/mach-pxa/em-x270.c                     |  2 ++
 arch/arm/mach-pxa/icontrol.c                    |  3 +++
 arch/arm/mach-pxa/trizeps4.c                    |  3 +++
 arch/arm/mach-pxa/vpac270.c                     |  3 +++
 arch/arm/mach-pxa/zeus.c                        |  2 ++
 35 files changed, 179 insertions(+), 57 deletions(-)
