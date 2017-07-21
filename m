From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 21 Jul 2017 12:25:35 +0530
Subject: [PATCH v2 0/7] FlexRM driver improvements
Message-ID: <1500620142-910-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does various improvments to Broadcom FlexRM
mailbox controller driver and also adds FlexRM DT nodes
for Stingray SOC.

The patches are based on Linux-4.13-rc1 and can also be
found at flexrm-imp-v2 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v1:
 - Add one more patch to use bitmap instead of IDA in FlexRM driver

Anup Patel (7):
  mailbox: bcm-flexrm-mailbox: Set IRQ affinity hint for FlexRM ring
    IRQs
  mailbox: bcm-flexrm-mailbox: Add debugfs support
  mailbox: bcm-flexrm-mailbox: Fix mask used in CMPL_START_ADDR_VALUE()
  mailbox: bcm-flexrm-mailbox: Use bitmap instead of IDA
  mailbox: Make message send queue size dynamic in Linux mailbox
  mailbox: bcm-flexrm-mailbox: Set msg_queue_len for each channel
  arm64: dts: Add FlexRM DT nodes for Stingray

 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   |  54 ++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   2 +
 drivers/mailbox/bcm-flexrm-mailbox.c               | 196 ++++++++++++++++++---
 drivers/mailbox/mailbox.c                          |  15 +-
 include/linux/mailbox_controller.h                 |   5 +-
 5 files changed, 246 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi

-- 
2.7.4
