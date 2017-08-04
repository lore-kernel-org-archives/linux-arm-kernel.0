From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 4 Aug 2017 19:59:35 +0800
Subject: [PATCH v6 0/2] Add basic support for Mediatek MT2712 SoC
Message-ID: <1501847977-4023-1-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2712 is a SoC based on 64bit ARMv8 architecture.
MT2712 share many HW IP with MT8173.  This patchset was tested on MT2712 evaluation board, and boot to shell ok.

This series contains document bindings, device tree including interrupt and uart.

Changes compared to v5:
- remove the soc node

Changes compared to v4:
- rebase to 4.13-rc1
- use two clocks (baud_clk & sys_clk) instead of one uart_clk to the correct bindings

Changes compared to v3:
- use two uart clocks refer to the bindings

Changes compared to v2:
- remove alias from serial1 to serial5
- remove initrd-start and initrd-end
- change GIC_CPU_MASK_SIMPLE(6) to GIC_CPU_MASK_RAW(0x13)
- change gic-400 reg range

Changes compared to v1:
- change subject prefix for bindings
- change device tree license to SPDX tag.
- change bootargs parameter to DT usage.
- change intpol-controller to interrupt-controller

YT Shen (2):
  dt-bindings: arm: Add bindings for Mediatek MT2712 SoC Platform
  arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and
    Makefile

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../interrupt-controller/mediatek,sysirq.txt       |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |  32 ++++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          | 171 +++++++++++++++++++++
 6 files changed, 210 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi

-- 
1.9.1
