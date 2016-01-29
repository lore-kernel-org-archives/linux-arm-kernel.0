From: qnguyen@apm.com (Quan Nguyen)
Date: Fri, 29 Jan 2016 11:28:52 +0700
Subject: [PATCH v5 0/3] Enable X-Gene standby GPIO as interrupt controller
Message-ID: <1454041735-8434-1-git-send-email-qnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V5 Changes:
        - Add optional properties to describe HW specifics
        - Use irq_create_fwspec_mapping() instead of low level functions
        - Move gpiochip_lock_as_irq() to activate method
        - Remove redundant checks
	- Add optional HW properties description to DT binding document
        - Update "interrupts" property description in DT binding document.
V4 Changes:
        - Convert to hierarchical irq domain
V3 Changes:
        - Picking up from version 2 of "Y Vo <yvo@apm.com>"
        - Get HW resource information from DT
        - Avoid keeping parent IRQ controller
V2 Changes:
        - Support X-Gene standby GPIO as an interrupt controller.

Quan Nguyen (3):
  gpio: xgene: Enable X-Gene standby GPIO as interrupt controller
  Documentation: gpio: Update description for X-Gene standby GPIO
    controller DTS binding
  arm64: dts: Update X-Gene standby GPIO controller DTS entries

 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |  47 +++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   3 +
 drivers/gpio/gpio-xgene-sb.c                       | 275 ++++++++++++++++++---
 3 files changed, 286 insertions(+), 39 deletions(-)

-- 
1.7.12.4
