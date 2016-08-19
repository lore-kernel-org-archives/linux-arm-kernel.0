From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:21 +0200
Subject: [PATCH v3 00/12] Initial Tegra186 support
Message-ID: <20160819173233.13260-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Hi everyone,

This is a set of patches to add initial support for Tegra186. It is
based on Joseph's patches but I rewrote some of the drivers to be a
little easier to comprehend and maintain (hopefully). I've also
included clock and reset drivers as a proof of concept.

Thierry

Joseph Lo (7):
  dt-bindings: mailbox: Add Tegra HSP binding
  dt-bindings: firmware: Add bindings for Tegra BPMP
  soc/tegra: Add Tegra186 support
  arm64: defconfig: Enable Tegra186 SoC
  arm64: dts: tegra: Add Tegra186 support
  arm64: dts: tegra: Add NVIDIA P3310 main board support
  arm64: dts: tegra: Add NVIDIA P2771 board support

Thierry Reding (5):
  mailbox: Add Tegra HSP driver
  firmware: tegra: Add IVC library
  firmware: tegra: Add BPMP support
  clk: tegra: Add BPMP clock driver
  reset: Add Tegra BPMP reset driver

 .../bindings/firmware/nvidia,tegra186-bpmp.txt     |   77 +
 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |   52 +
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |    8 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   34 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   86 ++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/tegra/Makefile                         |    1 +
 drivers/clk/tegra/clk-bpmp.c                       |  565 +++++++
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/tegra/Kconfig                     |   25 +
 drivers/firmware/tegra/Makefile                    |    2 +
 drivers/firmware/tegra/bpmp.c                      |  880 +++++++++++
 drivers/firmware/tegra/ivc.c                       |  683 +++++++++
 drivers/mailbox/Kconfig                            |    9 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/tegra-hsp.c                        |  561 +++++++
 drivers/reset/Makefile                             |    1 +
 drivers/reset/tegra/Makefile                       |    1 +
 drivers/reset/tegra/reset-bpmp.c                   |   63 +
 drivers/soc/tegra/Kconfig                          |   14 +
 include/dt-bindings/clock/tegra186-clock.h         |  940 ++++++++++++
 include/dt-bindings/mailbox/tegra186-hsp.h         |   24 +
 include/dt-bindings/reset/tegra186-reset.h         |  217 +++
 include/soc/tegra/bpmp-abi.h                       | 1601 ++++++++++++++++++++
 include/soc/tegra/bpmp.h                           |  122 ++
 include/soc/tegra/ivc.h                            |  109 ++
 28 files changed, 6081 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186.dtsi
 create mode 100644 drivers/clk/tegra/clk-bpmp.c
 create mode 100644 drivers/firmware/tegra/Kconfig
 create mode 100644 drivers/firmware/tegra/Makefile
 create mode 100644 drivers/firmware/tegra/bpmp.c
 create mode 100644 drivers/firmware/tegra/ivc.c
 create mode 100644 drivers/mailbox/tegra-hsp.c
 create mode 100644 drivers/reset/tegra/Makefile
 create mode 100644 drivers/reset/tegra/reset-bpmp.c
 create mode 100644 include/dt-bindings/clock/tegra186-clock.h
 create mode 100644 include/dt-bindings/mailbox/tegra186-hsp.h
 create mode 100644 include/dt-bindings/reset/tegra186-reset.h
 create mode 100644 include/soc/tegra/bpmp-abi.h
 create mode 100644 include/soc/tegra/bpmp.h
 create mode 100644 include/soc/tegra/ivc.h

-- 
2.9.0
