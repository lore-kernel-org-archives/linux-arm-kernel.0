From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon, 12 Feb 2018 11:58:29 +0530
Subject: [PATCH v3 0/3] Add DTS for SDM845 SoC and MTP
Message-ID: <20180212062832.2791-1-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are basic device tree files needed to boot a SDM845 MTP
board to a ramfs based serial console shell

Bindings are based on whats proposed for pinctrl/serial/clock
drivers for SDM845 SoC
pinctrl: https://patchwork.kernel.org/patch/10157143/ (This is now pulled
in by Linus Walleij for 4.17)
clocks: https://lkml.org/lkml/2018/1/31/209 (under review)
serial: https://patchwork.ozlabs.org/cover/860251/ (under review)

'PATCH 3/3' is based on v2 of serial patches, will need an update if
v3 (still in the works) has further binding updates

Since 'PATCH 2/3' also adds an ITS node and keeps it disabled, we also depend
on https://lkml.org/lkml/2018/1/29/383

changes in v3:
* split the pinmux/pinconf nodes across SoC/Board files
* Fixes for issues reported with 'make dtbs W=2'
* other minor fixes based on review
 
changes in v2:
* dropped cpu-map
* dropped GIC_CPU_MASK_SIMPLE()
* Added new cpu compatible for kryo385
* added ITS node, marked as disabled
* other cosmetic fixes

Rajendra Nayak (3):
  dt-bindings: arm: Document kryo385 cpu
  arm64: dts: sdm845: Add minimal dts files for sdm845 SoC/MTP
  arm64: dts: sdm845: Add serial console support

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 arch/arm64/boot/dts/qcom/Makefile              |   1 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts        |  47 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi           | 314 +++++++++++++++++++++++++
 4 files changed, 363 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
