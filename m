From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 31 Mar 2016 11:47:56 +0900
Subject: [PATCH v4 0/9] ARM: dts: Add new Exynos3250-based ARTIK5 module dtsi
 file
Message-ID: <1459392485-11327-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add the support for Device Tree source for Samsung ARTIK5 module[1]
based on Exynos3250 SoC and development board[2]. The ARTIK5 module includes
the follwoing devices:
- Application Processor (Samsung Exynos3250)
- WiFi/BT Combo chip
- PMIC (Samsung S2MPS14)
- eMMC (4GB)
- DRAM LPDDR3 (512MB)
- Connectors pin (60 Pins x 3 set)

Also, this patchset add the ARTIK5 development board[2] dts file which includes
the ARTIK5 module[1] and have the devices such as sound codec, sd card port,
ethernet port, uart port and so on.

[1] https://www.artik.io/hardware/artik-5
[2] http://www.digikey.com/product-detail/en/SIP-KITNXB001/1510-1316-ND/5825102

Changes from v3:
(https://lkml.org/lkml/2016/3/15/71)
- Add acked-by tag from Rob Herring <robh@kernel.org> (patch8)
- Fix typo on patch descritpion (patch8)
- Make the separate patch for including the new clock id
  for both MMC2 and UART2 device (patch2)

Changes from v2:
(https://lkml.org/lkml/2016/3/14/910)
- Add reviewed tag by Krzysztof Kozlowski for all patches
- Include the separate patch1[3] in patchset because patch5 depend on patch1[3]
  [3] https://lkml.org/lkml/2016/3/14/245
- Fix the order issue in exynos3250-artik5.dtsi
- Use lowercase for hex address in exynos3250-artik5.dtsi

Changes from v1:
(https://lkml.org/lkml/2016/3/13/215)
- Change the board name from 'artik5-devel' to 'artik5-eval'
- Merge the patch6/7/8 to patch5
- Add the new board information to samsung-boards.txt[1]
  [1] Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
- Fix minor coding style issue and remove 'wakeup' property
- Remove 'broken-cd' and 'desc-num' property from mshc_0 node
- Handle the LDO11/LDO12 by using XMMC0CDn pin (GPK0-2 gpio) for MMC device
  and fix the ldo number of 'vmmc-supply' property.
- Add the 'vqmmc-supply' property for MSHC2
- Drop the patch10 for PPMU node
- Add the new patch to initialize the MMC2 gpio pin on monk board

Chanwoo Choi (6):
  ARM: dts: Add initial pin configuration for exynos3250-rinato
  dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250
  clk: samsung: exynos3250: Add MMC2 clock
  ARM: dts: Add initial gpio setting of MMC2 device for exynos3250-monk
  ARM: dts: Add MSHC2 dt node for Exynos3250 SoC
  ARM: dts: Add exynos3250-artik5 dtsi file for ARTIK5 module

Jaehoon Chung (1):
  ARM: dts: Add MSHC2 dt node for SD card for exynos3250-artik5-eval board

Pankaj Dubey (2):
  clk: samsung: exynos3250: Add UART2 clock
  ARM: dts: Add UART2 dt node for Exynos3250 SoC

 .../bindings/arm/samsung/samsung-boards.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |  43 +++
 arch/arm/boot/dts/exynos3250-artik5.dtsi           | 334 +++++++++++++++++++++
 arch/arm/boot/dts/exynos3250-monk.dts              |  12 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          |  80 +++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  71 ++++-
 arch/arm/boot/dts/exynos3250.dtsi                  |  25 ++
 drivers/clk/samsung/clk-exynos3250.c               |  15 +
 include/dt-bindings/clock/exynos3250.h             |  11 +-
 10 files changed, 590 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5-eval.dts
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5.dtsi

-- 
1.9.1
