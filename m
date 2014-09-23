From: carlo@caione.org (Carlo Caione)
Date: Tue, 23 Sep 2014 21:52:21 +0200
Subject: [GIT PULL] meson: basic support for MesonX SoCs
Message-ID: <20140923195221.GA30267@nuc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here the pull request to introduce preliminary support for MesonX SoCs.
It is based on the patchset at:

http://www.spinics.net/lists/arm-kernel/msg362521.html

and it is based on the master of arm-soc tree.

BR,

--

The following changes since commit 7505ceaf863590b24a4c0c83b64817d26e0d51e3:

  Merge branch 'irq-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2014-09-01 10:36:27 -0700)

are available in the git repository at:


  https://github.com/carlocaione/linux-meson meson-v3.18-next

for you to fetch changes up to 8fba35ce6ce32ed348a00bf917095977883f29af:

  MAINTAINERS: Add entry for the Amlogic MesonX SoCs (2014-09-23 20:17:21 +0200)

----------------------------------------------------------------
Carlo Caione (6):
      ARM: meson: debug: add debug UART for earlyprintk support
      ARM: meson: documentation: add bindings documentation
      ARM: meson: add basic support for MesonX SoCs
      ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200 DTSI/DTS
      ARM: meson: update multi_v7_defconfig
      MAINTAINERS: Add entry for the Amlogic MesonX SoCs

 Documentation/devicetree/bindings/arm/amlogic.txt  |   8 ++
 .../devicetree/bindings/arm/geniatech.txt          |   5 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |   6 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  14 ++-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/meson.dtsi                       | 105 +++++++++++++++++++++
 arch/arm/boot/dts/meson6-atv1200.dts               |  66 +++++++++++++
 arch/arm/boot/dts/meson6.dtsi                      |  78 +++++++++++++++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/include/debug/meson.S                     |  35 +++++++
 arch/arm/mach-meson/Kconfig                        |  13 +++
 arch/arm/mach-meson/Makefile                       |   1 +
 arch/arm/mach-meson/meson.c                        |  27 ++++++
 16 files changed, 365 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/amlogic.txt
 create mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt
 create mode 100644 arch/arm/boot/dts/meson.dtsi
 create mode 100644 arch/arm/boot/dts/meson6-atv1200.dts
 create mode 100644 arch/arm/boot/dts/meson6.dtsi
 create mode 100644 arch/arm/include/debug/meson.S
 create mode 100644 arch/arm/mach-meson/Kconfig
 create mode 100644 arch/arm/mach-meson/Makefile
 create mode 100644 arch/arm/mach-meson/meson.c

-- 
Carlo Caione
