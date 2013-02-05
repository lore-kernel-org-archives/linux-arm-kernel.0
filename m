From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 11:02:52 +0800
Subject: [GIT PULL] imx device tree changes for 3.9
Message-ID: <20130205030250.GC10807@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.9

for you to fetch changes up to 4b74caaa3b5935fbc4a7660682b8cc78c9a5ffa9:

  ARM: dts: add dtsi for imx6q and imx6dl (2013-02-05 10:22:32 +0800)

----------------------------------------------------------------
imx device tree changes for 3.9

 - Some tweaking and updates on device tree sources
 - Enable imx6q-cpufreq support for device tree boot
 - One series converting imx onewire driver to device tree.  Onewire
   maintainer Evgeniy Polyakov gives his ACK to bless the series go
   via arm-soc tree.

----------------------------------------------------------------
Anson Huang (1):
      ARM: dts: i.MX6: Add regulator delay support

Fabio Estevam (5):
      ARM: dts: imx27-3ds: Rename it to imx27-pdk
      ARM: boot: dts: Add an entry for imx27-pdk.dtb
      ARM: mx25pdk: Add device tree support
      ARM: dts: imx25-karo-tx25: Put status entry in the end
      ARM: dts: imx6q: Remove silicon version from SDMA firmware

Laurent Cans (1):
      ARM: dts: Add apf51 basic support

Liu Ying (2):
      ARM: dts: imx: Add imx51 KPP entry
      ARM i.MX51 babbage: Add keypad support

Martin Fuzzey (5):
      W1: Add device tree support to MXC onewire master.
      W1: Convert MXC onewire master to devm_ functions.
      W1: Add pinctrl support to MXC onewire master.
      ARM: i.MX53: Add clocks for i.mx53 onewire master.
      ARM: dts: Add device tree entry for onewire master on i.MX53

Peter Chen (1):
      ARM i.MX6: change mxs usbphy clock usage

Sascha Hauer (1):
      ARM i.MX53: add dts for the TQ tqma53 module

Shawn Guo (5):
      ARM: dts: add missing imx dtb targets
      ARM: dts: imx: use nodes label in board dts
      ARM: imx: enable imx6q-cpufreq support
      ARM: dts: rename imx6q.dtsi to imx6qdl.dtsi
      ARM: dts: add dtsi for imx6q and imx6dl

Steffen Trumtrar (2):
      ARM: dts: imx53: pinctrl update
      ARM i.MX53: dts: add oftree for MBa53 baseboard

 Documentation/devicetree/bindings/arm/armadeus.txt |    6 +
 Documentation/devicetree/bindings/arm/fsl.txt      |    8 +
 .../devicetree/bindings/clock/imx5-clock.txt       |    1 +
 .../devicetree/bindings/clock/imx6q-clock.txt      |    2 +
 .../devicetree/bindings/w1/fsl-imx-owire.txt       |   19 +
 arch/arm/boot/dts/Makefile                         |   10 +-
 arch/arm/boot/dts/imx25-karo-tx25.dts              |   30 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   36 +
 arch/arm/boot/dts/imx25.dtsi                       |    2 +-
 arch/arm/boot/dts/imx27-apf27.dts                  |   82 +-
 arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} |   24 +-
 arch/arm/boot/dts/imx31-bug.dts                    |   12 +-
 arch/arm/boot/dts/imx51-apf51.dts                  |   52 ++
 arch/arm/boot/dts/imx51-babbage.dts                |  478 ++++++------
 arch/arm/boot/dts/imx51.dtsi                       |   53 ++
 arch/arm/boot/dts/imx53-ard.dts                    |  126 ++-
 arch/arm/boot/dts/imx53-evk.dts                    |  194 +++--
 arch/arm/boot/dts/imx53-mba53.dts                  |  130 ++++
 arch/arm/boot/dts/imx53-qsb.dts                    |  380 +++++-----
 arch/arm/boot/dts/imx53-smd.dts                    |  294 ++++---
 arch/arm/boot/dts/imx53-tqma53.dtsi                |  172 +++++
 arch/arm/boot/dts/imx53.dtsi                       |   68 ++
 arch/arm/boot/dts/imx6dl.dtsi                      |   59 ++
 arch/arm/boot/dts/imx6q-arm2.dts                   |  124 ++-
 arch/arm/boot/dts/imx6q-sabreauto.dts              |   64 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |  216 +++---
 arch/arm/boot/dts/imx6q-sabresd.dts                |  102 ++-
 arch/arm/boot/dts/imx6q.dtsi                       |  796 +------------------
 arch/arm/boot/dts/imx6qdl.dtsi                     |  800 ++++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |    4 +-
 arch/arm/mach-imx/clk-imx6q.c                      |   26 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   65 ++
 drivers/w1/masters/mxc_w1.c                        |   45 +-
 33 files changed, 2576 insertions(+), 1904 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/armadeus.txt
 create mode 100644 Documentation/devicetree/bindings/w1/fsl-imx-owire.txt
 create mode 100644 arch/arm/boot/dts/imx25-pdk.dts
 rename arch/arm/boot/dts/{imx27-3ds.dts => imx27-pdk.dts} (59%)
 create mode 100644 arch/arm/boot/dts/imx51-apf51.dts
 create mode 100644 arch/arm/boot/dts/imx53-mba53.dts
 create mode 100644 arch/arm/boot/dts/imx53-tqma53.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl.dtsi
