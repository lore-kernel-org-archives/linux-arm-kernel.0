From: rob.rice@broadcom.com (Rob Rice)
Date: Thu, 30 Jun 2016 15:59:21 -0400
Subject: [PATCH v2 0/3] Add Broadcom PDC mailbox driver
Message-ID: <1467316764-19686-1-git-send-email-rob.rice@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Rice <rrice@broadcom.com>

Changes in v2:
- Added COMPILE_TEST depend to PDC Kconfig
- Renamed pdc.c to bcm-pdc-mailbox.c and moved it from subdirectory
  to drivers/mailbox
- Moved code from pdc.h, pdc_debug.h, and pdc_debug.c into
  bcm-pdc-mailbox.c
- Removed a few function parameters

The Broadcom PDC mailbox driver is a ring manager for the Broadcom
Secure Processing Unit (SPU) kernel driver and other mailbox clients.
The PDC driver registers with the Linux mailbox framework a mailbox
controller, once for each PDC instance. Ring 0 for each PDC is registered as
a mailbox channel. The PDC driver uses interrupts to determine when ring
transfers to and from an offload engine are complete. The PDC driver uses
threaded IRQs so that response messages are handled outside of interrupt
context.

Rob Rice (3):
  dt-bindings: add bindings documentation for PDC driver.
  mailbox: Add Broadcom PDC mailbox driver
  arm64: dts: Add Broadcom Northstar2 device tree entries for PDC
    driver.

 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |   23 +
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |   36 +
 drivers/mailbox/Kconfig                            |    9 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/bcm-pdc-mailbox.c                  | 1531 ++++++++++++++++++++
 include/linux/mailbox/brcm-message.h               |   56 +
 6 files changed, 1657 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-pdc-mbox.txt
 create mode 100644 drivers/mailbox/bcm-pdc-mailbox.c
 create mode 100644 include/linux/mailbox/brcm-message.h

-- 
2.1.0
