From: jay.xu@rock-chips.com (jianqun.xu)
Date: Fri, 19 Feb 2016 09:56:12 +0800
Subject: [PATCH v4 0/6] Add core dtsi for rk3399 from Rockchip
Message-ID: <1455846978-4272-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jianqun Xu <jay.xu@rock-chips.com>

There is the new SoCs from Rockchip which named rk3399, the
patches are added to support them.

Jianque Xu (4):
  soc: rockchip: add bindings for Rockchip grf
  spi: rockchip: add bindings for rk3399 spi
  ASoC: rockchip: add bindings for rk3399 i2s
  ARM64: dts: rockchip: add core dtsi file for rk3399

Xing Zheng (2):
  clk: rockchip: add dt-binding header for rk3399
  dt-bindings: add documentation of rk3399 clock controller

 .../bindings/clock/rockchip,rk3399-cru.txt         |  82 ++
 .../devicetree/bindings/soc/rockchip/grf.txt       |  35 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |   1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 949 +++++++++++++++++++++
 drivers/spi/spi-rockchip.c                         |   1 +
 include/dt-bindings/clock/rk3399-cru.h             | 609 +++++++++++++
 7 files changed, 1678 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.txt
 create mode 100644 Documentation/devicetree/bindings/soc/rockchip/grf.txt
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
 create mode 100644 include/dt-bindings/clock/rk3399-cru.h

-- 
changes in v4:
- restore rockchip-i2s.txt patch for rk3399-i2s (Rob)
- add grf.txt for rockchip grf (Rob, Heiko)
- reset my author name to keep same with signoff

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
