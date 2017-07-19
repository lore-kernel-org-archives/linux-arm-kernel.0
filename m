From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 19 Jul 2017 15:25:36 +0530
Subject: [PATCH 0/6] FlexRM driver improvements
Message-ID: <1500458142-19243-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does various improvments to Broadcom FlexRM
mailbox controller driver and also adds FlexRM DT nodes
for Stingray SOC.

The patches are based on Linux-4.13-rc1 and can also be
found at flexrm-imp-v1 branch of
https://github.com/Broadcom/arm64-linux.git

Anup Patel (6):
  mailbox: bcm-flexrm-mailbox: Set IRQ affinity hint for FlexRM ring
    IRQs
  mailbox: bcm-flexrm-mailbox: Add debugfs support
  mailbox: bcm-flexrm-mailbox: Fix mask used in CMPL_START_ADDR_VALUE()
  mailbox: Make message send queue size dynamic in Linux mailbox
  mailbox: bcm-flexrm-mailbox: Set msg_queue_len for each channel
  arm64: dts: Add FlexRM DT nodes for Stingray

 .../boot/dts/broadcom/stingray/stingray-fs4.dtsi   |  54 +++++++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   2 +
 drivers/mailbox/bcm-flexrm-mailbox.c               | 160 ++++++++++++++++++++-
 drivers/mailbox/mailbox.c                          |  15 +-
 include/linux/mailbox_controller.h                 |   5 +-
 5 files changed, 227 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi

-- 
2.7.4
