From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 25 Feb 2014 16:50:31 -0500
Subject: [PATCH 0/4] ARM: dts: keystone: Add support for K2H and K2E SOCs/EVMs
Message-ID: <1393365035-20083-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Series adds support for two Keystone2 SOCs called Lammar(K2L) and Edision(K2E)
with respective EVMs. As seen from changes, just device tree updates are needed
to support the SOCs and EVMs which is the goal with DT :)

Kyetsone2 Edision SOC(K2E):
- It is a Quad Cortex A15 based SoC with 1 DSP.
- Standard peripherals such as i2c, spi, uart, timer, etc similar to K2H.
- Additional instances of PCIE and USB
- No wireless hardware accelerators.

Keystone2 Lamarr SOC(K2L):
- It is a dual Cortex A15 core based SoC with 4 DSPs.
- Standard peripherals such as i2c, spi, uart, timer, pcie etc., similar to K2H
- Different set of wireless hardware w.r.t K2H.

Series has been boot tested on K2L and K2E EVMs.

Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>

Murali Karicheri (4):
  ARM: dts: keystone: update for supporting K2L/K2E EVMs
  ARM: dts: keystone: preparatory patch to support K2L and K2E SOCs
  ARM: dts: keystone: add support for K2 Lamarr SoC and EVM
  ARM: dts: keystone: add support for k2 Edison SoC and EVM

 .../devicetree/bindings/arm/keystone/keystone.txt  |   10 +
 arch/arm/boot/dts/k2e-clocks.dtsi                  |   78 ++++
 arch/arm/boot/dts/k2e-evm.dts                      |   60 +++
 arch/arm/boot/dts/k2e.dtsi                         |   80 ++++
 arch/arm/boot/dts/k2hk-clocks.dtsi                 |  426 ++++++++++++++++++++
 arch/arm/boot/dts/k2hk-evm.dts                     |    6 +-
 arch/arm/boot/dts/k2hk.dtsi                        |   46 +++
 arch/arm/boot/dts/k2l-clocks.dtsi                  |  267 ++++++++++++
 arch/arm/boot/dts/k2l-evm.dts                      |   37 ++
 arch/arm/boot/dts/k2l.dtsi                         |   55 +++
 arch/arm/boot/dts/keystone-clocks.dtsi             |  405 -------------------
 arch/arm/boot/dts/keystone.dtsi                    |   31 --
 arch/arm/mach-keystone/keystone.c                  |    3 +
 13 files changed, 1066 insertions(+), 438 deletions(-)
 create mode 100644 arch/arm/boot/dts/k2e-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2e-evm.dts
 create mode 100644 arch/arm/boot/dts/k2e.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2hk.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/k2l-evm.dts
 create mode 100644 arch/arm/boot/dts/k2l.dtsi

Regards,
Santosh
-- 
1.7.9.5
