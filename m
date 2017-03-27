From: cl@rock-chips.com (cl at rock-chips.com)
Date: Mon, 27 Mar 2017 17:40:45 +0800
Subject: [PATCH v4 0/6] initialize dtsi file and dts file for RK3328 SoCs
Message-ID: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Changes in v4:
    Remove some assigned-clocks as they should be inited in their
    respective device nodes.

Changes in v3:
    Adjust some descriptions in dtsi.

Changes in v2:
    Remove RK_FUNC_* in dtsi as it dose not help understand things better.
    Adjust the order of description in dt-bindings.

v1:
These patchs depend on pinctrl patchs as below:

https://patchwork.kernel.org/patch/9566427/
https://patchwork.kernel.org/patch/9566425/
https://patchwork.kernel.org/patch/9566431/

Liang Chen (6):
  dt-bindings: iio: rockchip-saradc: add support for rk3328
  dt-bindings: i2c: rk3x: add support for rk3328
  dt-bindings: soc: rockchip: grf: add support for rk3328
  arm64: dts: rockchip: add core dtsi file for RK3328 SoCs
  arm64: dts: rockchip: add dts file for RK3328
  dt-bindings: document rockchip rk3328-evb board

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |    1 +
 .../bindings/iio/adc/rockchip-saradc.txt           |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |   57 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 1275 ++++++++++++++++++++
 7 files changed, 1340 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328.dtsi

-- 
1.9.1
