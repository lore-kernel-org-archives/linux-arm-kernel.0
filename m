From: eddie.huang@mediatek.com (Eddie Huang)
Date: Fri, 26 Dec 2014 16:26:53 +0800
Subject: [PATCH v3 0/4] Add basic support for Mediatek MT8173 SoC 
Message-ID: <1419582417-4448-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT8173 is a SoC based on 64bit ARMv8 architecture. It contains 2 CA53 + 2 CA57 cores.
MT8173 share many HW IP with MT8135 and other MT65xx series. This patchset was tested
on MT8173 engineer sample, and boot to shell ok.

This series contains document bindings, device tree, defconfig, and one sysirq
modification for MT8173.

Changes in v3:

1. Modify mt8173.dtsi according Mark Rutland review comment, CPU ID, PSCI and GIC address.
2. Include interrupt dt-binding header files, replace interrupt number by enum value.
3. Rebase to 3.19-rc1, create arch/arm64/boot/dts/mediatek folder to put mt8173.dtsi.

This patch base on 3.19-rc1, Joe's sysirq patch [1] and test boot to shell with
Catalin Marinas's arch_timer virtual counter patch [2]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310335.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309856.html

Eddie Huang (3):
  Document: DT: Add bindings for mediatek MT8173 Soc Platform
  arm64: dts: Add mediatek MT8173 SoC and evaluation board dts and
    Makefile
  arm64: mediatek: Add MT8173 SoC Kconfig and defconfig

Yingjoe Chen (1):
  irqchip: mtk-sysirq: Get irq number from register resource size

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 arch/arm64/Kconfig                                 |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   5 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts        |  34 +++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           | 159 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/irqchip/irq-mtk-sysirq.c                   |  18 ++-
 8 files changed, 222 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/Makefile
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173.dtsi

--
1.8.1.1.dirty

************* Email Confidentiality Notice ********************
The information contained in this e-mail message (including any 
attachments) may be confidential, proprietary, privileged, or otherwise
exempt from disclosure under applicable laws. It is intended to be 
conveyed only to the designated recipient(s). Any use, dissemination, 
distribution, printing, retaining or copying of this e-mail (including its 
attachments) by unintended recipient(s) is strictly prohibited and may 
be unlawful. If you are not an intended recipient of this e-mail, or believe 
that you have received this e-mail in error, please notify the sender 
immediately (by replying to this e-mail), delete any and all copies of 
this e-mail (including any attachments) from your system, and do not
disclose the content of this e-mail to any other person. Thank you!
