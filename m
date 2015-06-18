From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 18 Jun 2015 14:13:41 -0700
Subject: [PATCH 0/4] Qualcomm Switch-Mode Battery Charger and Boost
Message-ID: <1434662025-9485-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds bindings and a device driver for the Qualcomm Switch-Mode
Battery Charger and Boost block found in pm8941.

Bjorn Andersson (4):
  spmi: pmic-arb: add irq_get_irqchip_state implementation
  dt-binding: power: Add Qualcomm SMBB binding
  power: Add Qualcomm SMBB driver
  ARM: dts: qcom-pm8941: Add charger node

 .../devicetree/bindings/power_supply/qcom_smbb.txt | 137 +++
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  21 +
 drivers/power/Kconfig                              |  12 +
 drivers/power/Makefile                             |   1 +
 drivers/power/qcom_smbb.c                          | 952 +++++++++++++++++++++
 drivers/spmi/spmi-pmic-arb.c                       |  17 +
 6 files changed, 1140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
 create mode 100644 drivers/power/qcom_smbb.c

-- 
1.8.2.2
