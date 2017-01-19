From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Wed, 18 Jan 2017 17:39:37 -0800
Subject: [PATCH v2 0/3] Add support for Broadcom iProc mailbox controller
Message-ID: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contains mailbox support for Broadcom iProc based SoC's. The
mailbox controller handles all communication with a Cortex-M0 MCU processor that
provides support for power, clock, and reset management.

The patch set enables the mailbox controller for Cygnus and also interrupt
support for the Cygnus CRMU GPIO driver which requires use of the M0 processor.

Changes from v1:
- Interrupt handling has been removed and will be added to an interrupt
  controller driver and sent out in a separate patchset.
- Moved location of bcm_iproc_mailbox.h to include/linux/mailbox as suggested by
  Jassi.
- Removed reading of client timeout from driver and used canned timeout. This
  removes the need of including the client mailbox header.

Jonathan Richardson (3):
  dt-bindings: Document Broadcom iProc mailbox controller driver
  mailbox: Add iProc mailbox controller driver
  ARM: dts: Enable Broadcom iProc mailbox controller

 .../bindings/mailbox/brcm,iproc-mailbox.txt        |  14 ++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   6 +
 drivers/mailbox/Kconfig                            |  10 ++
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/bcm-iproc-mailbox.c                | 199 +++++++++++++++++++++
 include/linux/mailbox/bcm_iproc_mailbox.h          |  32 ++++
 6 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
 create mode 100644 drivers/mailbox/bcm-iproc-mailbox.c
 create mode 100644 include/linux/mailbox/bcm_iproc_mailbox.h

-- 
1.9.1
