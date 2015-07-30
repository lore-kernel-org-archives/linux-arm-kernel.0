From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 30 Jul 2015 10:53:53 -0700
Subject: [PATCHv2 0/4] Qualcomm Switch-Mode Battery Charger and Boost
Message-ID: <1438278837-29967-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds bindings and a device driver for the Qualcomm Switch-Mode
Battery Charger and Boost block found in pm8941.

Changes since v1:
- Corrected authorship of the patches
- Gave dt properties qcom vendor prefix
- Updated names of dt properties
- Dropped MODULE_ALIAS

Courtney Cavin (4):
  spmi: pmic-arb: add support for irq_get_irqchip_state
  dt-binding: power: Add Qualcomm SMBB binding
  power: Add Qualcomm SMBB driver
  ARM: dts: qcom-pm8941: Add charger node

 .../devicetree/bindings/power_supply/qcom_smbb.txt | 131 +++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  21 +
 drivers/power/Kconfig                              |  12 +
 drivers/power/Makefile                             |   1 +
 drivers/power/qcom_smbb.c                          | 951 +++++++++++++++++++++
 drivers/spmi/spmi-pmic-arb.c                       |  17 +
 6 files changed, 1133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
 create mode 100644 drivers/power/qcom_smbb.c

-- 
1.8.2.2
