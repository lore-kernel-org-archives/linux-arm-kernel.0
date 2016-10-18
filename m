From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Tue, 18 Oct 2016 12:00:34 -0700
Subject: [PATCH v1 0/4] Add support for Broadcom iProc mailbox controller
Message-ID: <1476817238-1226-1-git-send-email-jonathan.richardson@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set contains mailbox support for Broadcom iProc based SoC's. The
mailbox controller handles all communication with a Cortex-M0 MCU processor that
provides support for power, clock, and reset management.

The patch set enables the mailbox controller for Cygnus and also interrupt
support for the Cygnus CRMU GPIO driver which requires use of the M0 processor.

Jonathan Richardson (4):
  dt-bindings: Document Broadcom iProc mailbox controller driver
  mailbox: Add iProc mailbox controller driver
  ARM: dts: Enable Broadcom iProc mailbox controller
  ARM: dts: Enable interrupt support for cygnus crmu gpio driver

 .../bindings/mailbox/brcm,iproc-mailbox.txt        |  20 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  12 +
 drivers/mailbox/Kconfig                            |  10 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/bcm-iproc-mailbox.c                | 422 +++++++++++++++++++++
 include/linux/bcm_iproc_mailbox.h                  |  32 ++
 6 files changed, 498 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
 create mode 100644 drivers/mailbox/bcm-iproc-mailbox.c
 create mode 100644 include/linux/bcm_iproc_mailbox.h

-- 
1.9.1
