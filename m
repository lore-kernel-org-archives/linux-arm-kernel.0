From: mirza.krak@gmail.com (Mirza Krak)
Date: Sat,  6 Aug 2016 21:40:46 +0200
Subject: [PATCH 0/6] Add support for Tegra GMI bus controller
Message-ID: <1470512452-8322-1-git-send-email-mirza.krak@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mirza Krak <mirza.krak@gmail.com>

Hi.

This is a follow up to my previous RFC. Take a look at [1], [2] and [3] for
previous discussions.

I have tested this series on a Tegra30 using a Colibri T30 SOM on a custom
carrier board which has multiple CAN controllers (SJA1000) connected to the
GMI bus.

[1]. https://marc.info/?l=linux-clk&m=146893557629903&w=2
[2]. https://marc.info/?l=linux-tegra&m=146893541829801&w=2
[3]. https://marc.info/?l=linux-tegra&m=146893542429814&w=2

Mirza Krak (6):
  clk: tegra: add TEGRA20_CLK_NOR to init table
  clk: tegra: add TEGRA30_CLK_NOR to init table
  dt/bindings: Add bindings for Tegra GMI controller
  ARM: tegra: Add Tegra30 GMI support
  ARM: tegra: Add Tegra20 GMI support
  bus: Add support for Tegra Generic Memory Interface

 .../devicetree/bindings/bus/nvidia,tegra20-gmi.txt |  99 +++++++++
 arch/arm/boot/dts/tegra20.dtsi                     |  11 +
 arch/arm/boot/dts/tegra30.dtsi                     |  10 +
 drivers/bus/Kconfig                                |   7 +
 drivers/bus/Makefile                               |   1 +
 drivers/bus/tegra-gmi.c                            | 224 +++++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c                    |   1 +
 drivers/clk/tegra/clk-tegra30.c                    |   1 +
 8 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-gmi.txt
 create mode 100644 drivers/bus/tegra-gmi.c

--
2.1.4
