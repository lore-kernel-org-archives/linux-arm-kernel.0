From: jay.xu@rock-chips.com (jianqun.xu)
Date: Thu, 18 Feb 2016 19:16:29 +0800
Subject: [PATCH v3 0/4] add core dtsi file for rk3399
Message-ID: <1455794193-4497-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianqun Xu <jay.xu@rock-chips.com>

There is the new SoCs from Rockchip which named rk3399, the
patches are added to support them.

Xing Zheng (2):
  clk: rockchip: add dt-binding header for rk3399
  dt-bindings: add documentation of rk3399 clock controller

Xu Jianqun (2):
  spi: rockchip: add bindings for rk3399 spi
  ARM64: dts: rockchip: add core dtsi file for rk3399

 .../bindings/clock/rockchip,rk3399-cru.txt         |  82 ++
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 949 +++++++++++++++++++++
 drivers/spi/spi-rockchip.c                         |   1 +
 include/dt-bindings/clock/rk3399-cru.h             | 609 +++++++++++++
 5 files changed, 1642 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
 create mode 100644 include/dt-bindings/clock/rk3399-cru.h

--
changes in v3:
- add compatible for rk3399 spi (Mark, Heiko)

changes in v2:
- remove changeID (Heiko, Mark)
- drop pmu and psci temporary (Mark)
- drop applied patch (Heiko)
- drop GIC_CPU_MASK_SIMPLE from the interrupt specifiers (Marc, Heiko)
- drop clock-frequency of timer (Marc, Mark)
- remove double defination for SCLK_SPI5

1.9.1
