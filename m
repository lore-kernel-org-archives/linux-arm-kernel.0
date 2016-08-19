From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 19 Aug 2016 09:13:28 +0800
Subject: [PATCH v6 0/7] power: act8945a_charger: Improvements
Message-ID: <1471569215-6046-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is to improve the implementation of act8945a-charger
driver, such as improve the way to check the status, fix the power
supply type property, add the status change update, and add more
properties: capacity level property and max current property.

Changes in v6:
 - Add .remove callback function.
 - Fix the 'dev' argument of devm_request_irq() to pdev->dev.parent.
 - For 'lbo-gpios', use gpiod API instead of old gpio API to handle.
 - For 'chglev-gpios', use gpiod API instead of old gpio API to handle.

Changes in v5:
 - Add Acked-by tag.

Changes in v4:
 - Use "interrupts" property, instead of "active-semi,irq-gpios"
   for irq.
 - Change devname of devm_request_irq() from "lbo-detect" to
   "act8945a, lbo-detect".
 - Fix wrong gpio assignment for chglev_pin.
 - Update the doc/binding for using "interrupts" property.

Changes in v3:
 - Remove unneeded semicolon to fix semicolon.cocci warning.

Changes in v2:
 - Add missing ret declaration.

Wenyou Yang (7):
  power: act8945a_charger: Remove "battery_temperature"
  power: act8945a_charger: Improve
  power: act8945a_charger: Add status change update support
  power: act8945a_charger: Fix the power supply type
  power: act8945a_charger: Add capacity level property
  power: act8945a_charger: Add max current property
  doc: bindings: act8945a-charger: Update properties

 .../bindings/power/supply/act8945a-charger.txt     |  16 +-
 drivers/power/supply/act8945a_charger.c            | 390 ++++++++++++++++++---
 2 files changed, 358 insertions(+), 48 deletions(-)

-- 
2.7.4
