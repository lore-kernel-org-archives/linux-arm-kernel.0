From: qnguyen@apm.com (Quan Nguyen)
Date: Tue, 26 Jan 2016 14:22:12 +0700
Subject: [PATCH v4 0/3] Enable X-Gene standby GPIO as interrupt controller
Message-ID: <1453792935-19916-1-git-send-email-qnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V4 Changes:
        - Convert to hierarchical irq domain.
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

 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |  39 ++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   3 +
 drivers/gpio/gpio-xgene-sb.c                       | 331 +++++++++++++++++----
 3 files changed, 312 insertions(+), 61 deletions(-)

-- 
1.7.12.4
