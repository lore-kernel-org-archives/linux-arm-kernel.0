From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 22 Dec 2015 22:45:57 +0800
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 4.5
In-Reply-To: <1450795558-10961-1-git-send-email-shawnguo@kernel.org>
References: <1450795558-10961-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1450795558-10961-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This is the i.MX device tree updates for 4.5.  To resolve the dependency
between clock drivers and DTS files on some new clock ID additions, the
branches imx/fixes and imx/clk are pulled into the branch.  The clock
changes have been sent to clk folks as a stable branch.

Shawn

The following changes since commit c89dcce4e11c1653ca7954a9dc2839b4d8cd6b4b:

  Merge branch 'imx/clk' into imx/dt (2015-12-22 20:40:27 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.5

for you to fetch changes up to 67fea0f43d151a4688df1fa4c945f72a26dfb545:

  ARM: dts: imx7d: sbc-imx7: add basic board support (2015-12-22 20:43:43 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 4.5:
- New boards support: imx51-ts4800, imx6q-novena, CompuLab imx7d SoM/SBC,
  vf610m4-cosmic
- Add ADC device support for imx6ul and imx7d
- Remove config space from PCIe controller ranges property for i.MX6
- Add Vivante GPU nodes for i.MX6
- Add DCU, LCD, and SATA devices for LS1021A
- A series to update Ventana gw5xxx boards getting HDMI and LVDS to work
  simultaneously and devices like PWM and SPI added
- Quite a few random cleanups and minor updates

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: dts: vf6xx: Cosmic+: M4(nommu) initial support

Alexandre Belloni (1):
      ARM: mxs: dt: cfa10057: fix backlight PWM

Bai Ping (1):
      ARM: dts: imx: modify the clocks used by cpufreq driver

Cory Tusar (1):
      ARM: dts: vfxxx: Include support for dspi[23] functionality.

Damien Riegel (7):
      of: add vendor prefix for Technologic Systems
      of: documentation: add bindings documentation for TS-4800
      ARM: dts: TS-4800: add basic device tree
      ARM: dts: TS-4800: drop uart rts/cts pin reservations
      ARM: dts: TS-4800: use weim IP to map the FPGA
      ARM: dts: ts-4800: Add LCD support
      ARM: dts: TS-4800: add touchscreen support

Fabio Estevam (2):
      ARM: dts: imx6sx: Pass the 'adck-max-frequency' property
      ARM: dts: imx6ul: Add ADC support

Haibo Chen (2):
      ARM: dts: imx7d.dtsi: add ADC support
      ARM: dts: imx7d-sdb: add ADC support

Ilya Ledvich (2):
      ARM: dts: imx7d: cl-som-imx7: add basic module support
      ARM: dts: imx7d: sbc-imx7: add basic board support

Lucas Stach (3):
      ARM: dts: imx6: remove config space from PCIe controller ranges property
      ARM: dts: imx6qdl: move GIC to right location in DT
      ARM: dts: imx6: add Vivante GPU nodes

Mans Rullgard (1):
      ARM: dts: imx28: add alternate auart4 pinmux

Marc Kleine-Budde (1):
      ARM: dts: imx25: add alias for pwm nodes

Markus Pargmann (1):
      ARM: dts: imx6dl: Fix gpt compatibles, remove imx6q-gpt

Meng Yi (2):
      ARM: dts: ls1021a: Add DCU dts node.
      ARM: dts: ls1021a: Add a TFT LCD panel.

Peter Chen (2):
      ARM: dts: imx6: set ahb-burst-config as 0 for USB
      ARM: dts: imx6: change default burst size for USB

Philipp Zabel (1):
      ARM: dts: imx6qdl: add IPU aliases

Sean Cross (2):
      devicetree: bindings: Add vendor prefix for Kosagi
      ARM: dts: imx6q: add Novena board

Shengjiu Wang (1):
      ARM: dts: imx6: Change the clock name for spba clock

Stefan Agner (1):
      ARM: dts: vf-colibri: add CAN support

Tang Yuantian (1):
      ARM: dts: ls1021a: add sata node to dts

Tim Harvey (5):
      ARM: dts: imx: ventana: GW54xx PMIC swbst reg always-on
      ARM: dts: imx: ventana: fix GW53xx/GW54xx lvds channel
      ARM: dts: imx: ventana: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx: ventana: add PWM nodes for Ventana boards
      ARM: dts: imx: ventana: Add SPI support for GW52xx

Uwe Kleine-K?nig (1):
      ARM: dts: imx25-pinfunc: add some more pin configurations

 .../devicetree/bindings/arm/technologic.txt        |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   7 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  |   3 +
 arch/arm/boot/dts/imx25.dtsi                       |   4 +
 arch/arm/boot/dts/imx28-cfa10057.dts               |   4 +-
 arch/arm/boot/dts/imx28.dtsi                       |  11 +
 arch/arm/boot/dts/imx51-ts4800.dts                 | 302 ++++++++
 arch/arm/boot/dts/imx6dl.dtsi                      |   7 +-
 arch/arm/boot/dts/imx6q-novena.dts                 | 785 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi                       |  16 +
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |  36 +
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |  48 ++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |  33 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |  47 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi              |  24 +
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi              |  24 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |  61 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  11 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  19 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  18 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            | 286 ++++++++
 arch/arm/boot/dts/imx7d-sbc-imx7.dts               |  42 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  10 +
 arch/arm/boot/dts/imx7d.dtsi                       |  22 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  |   4 +
 arch/arm/boot/dts/ls1021a-twr.dts                  |  13 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  21 +
 arch/arm/boot/dts/vf-colibri.dtsi                  |  26 +
 arch/arm/boot/dts/vf610m4-cosmic.dts               |  90 +++
 arch/arm/boot/dts/vfxxx.dtsi                       |  24 +
 31 files changed, 1979 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
 create mode 100644 arch/arm/boot/dts/imx51-ts4800.dts
 create mode 100644 arch/arm/boot/dts/imx6q-novena.dts
 create mode 100644 arch/arm/boot/dts/imx7d-cl-som-imx7.dts
 create mode 100644 arch/arm/boot/dts/imx7d-sbc-imx7.dts
 create mode 100644 arch/arm/boot/dts/vf610m4-cosmic.dts
