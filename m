From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 27 Jun 2016 17:02:38 +0800
Subject: [PATCH 00/10] arm64: tegra: add BPMP support
Message-ID: <20160627090248.23621-1-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series introduce the first announced Boot and Power Management Processor
(BPMP) for the new generation Tegra SoCs, which is designed for boot
process handling and offloading the power management tasks from the CPU.

We also add some very initial and basic support for Tegra186 SoC, which
supports debug console and initrd for initial bring up currently. More drivers
and functions can be supported based on this later.

Thanks,
Joseph

Joseph Lo (10):
  Documentation: dt-bindings: mailbox: tegra: Add binding for HSP
    mailbox
  mailbox: tegra-hsp: Add HSP(Hardware Synchronization Primitives)
    driver
  Documentation: dt-bindings: firmware: tegra: add bindings of the BPMP
  firmware: tegra: add IVC library
  firmware: tegra: add BPMP support
  soc/tegra: Add Tegra186 support
  arm64: defconfig: Enable Tegra186 SoC
  arm64: dts: tegra: Add Tegra186 support
  arm64: dts: tegra: Add NVIDIA Tegra186 P3310 main board support
  arm64: dts: tegra: Add NVIDIA P2771 board support

 .../bindings/firmware/nvidia,tegra186-bpmp.txt     |   61 +
 .../bindings/mailbox/nvidia,tegra186-hsp.txt       |   42 +
 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |    8 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   30 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   77 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/tegra/Kconfig                     |   25 +
 drivers/firmware/tegra/Makefile                    |    2 +
 drivers/firmware/tegra/bpmp.c                      |  713 +++++++++
 drivers/firmware/tegra/ivc.c                       |  659 ++++++++
 drivers/mailbox/Kconfig                            |    9 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/tegra-hsp.c                        |  306 ++++
 drivers/soc/tegra/Kconfig                          |   14 +
 include/dt-bindings/mailbox/tegra-hsp.h            |   20 +
 include/soc/tegra/bpmp.h                           |   29 +
 include/soc/tegra/bpmp_abi.h                       | 1601 ++++++++++++++++++++
 include/soc/tegra/ivc.h                            |  102 ++
 21 files changed, 3704 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/nvidia,tegra186-hsp.txt
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra186.dtsi
 create mode 100644 drivers/firmware/tegra/Kconfig
 create mode 100644 drivers/firmware/tegra/Makefile
 create mode 100644 drivers/firmware/tegra/bpmp.c
 create mode 100644 drivers/firmware/tegra/ivc.c
 create mode 100644 drivers/mailbox/tegra-hsp.c
 create mode 100644 include/dt-bindings/mailbox/tegra-hsp.h
 create mode 100644 include/soc/tegra/bpmp.h
 create mode 100644 include/soc/tegra/bpmp_abi.h
 create mode 100644 include/soc/tegra/ivc.h

-- 
2.9.0
