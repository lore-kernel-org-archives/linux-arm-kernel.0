From: mirza.krak@gmail.com (Mirza Krak)
Date: Wed, 24 Aug 2016 15:37:12 +0200
Subject: [PATCH v2 0/6] Add support for Tegra GMI bus controller
Message-ID: <1472045838-22628-1-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Hi.

This is a follow up to my previous RFC to add support for Tegra GMI bus
controller.

I have tested this series on a Tegra30 using a Colibri T30 SOM on a custom
carrier board which has multiple CAN controllers (SJA1000) connected to the
GMI bus.

I have rebased on top of latest tegra/for-next in V2. Also see individual
patches for changes in V2.

See below links for previous discussions.

Comments on RFC:
https://marc.info/?l=linux-clk&m=146893557629903&w=2
https://marc.info/?l=linux-tegra&m=146893541829801&w=2
https://marc.info/?l=linux-tegra&m=146893542429814&w=2

Comments on V1:
https://marc.info/?l=linux-arm-kernel&m=147051551821122&w=2
https://marc.info/?l=linux-arm-kernel&m=147051553121150&w=2
https://marc.info/?l=linux-arm-kernel&m=147194856600627&w=2
https://marc.info/?l=linux-arm-kernel&m=147072742432211&w=2


Mirza Krak (6):
  clk: tegra: add TEGRA20_CLK_NOR to init table
  clk: tegra: add TEGRA30_CLK_NOR to init table
  dt/bindings: Add bindings for Tegra GMI controller
  ARM: tegra: Add Tegra30 GMI support
  ARM: tegra: Add Tegra20 GMI support
  bus: Add support for Tegra Generic Memory Interface

 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt | 132 ++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |  13 ++
 arch/arm/boot/dts/tegra30.dtsi                     |  12 ++
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/tegra-gmi.c                            | 231 +++++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c                    |   1 +
 drivers/clk/tegra/clk-tegra30.c                    |   1 +
 8 files changed, 399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
 create mode 100644 drivers/bus/tegra-gmi.c

--
2.1.4
