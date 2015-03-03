From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  3 Mar 2015 10:41:20 +0000
Subject: [PATCH 0/3] mailbox: New mailbox driver for ST
Message-ID: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set provides support for ST's Mailbox IP.

In order to save IRQ lines, current platforms have been only been
given a single interrupt for receiving messages from co-processors.
The best way to work around this limitation is to use Mailbox 1
(A9) as the receiving MB.  This driver/binding then has the ability
to map the remaining Mailboxes back to Mailbox 1 where threaded
interrupts are used to extract data to send back to the user.

Lee Jones (3):
  ARM: STi: stih407-family: Add nodes for Mailbox
  mailbox: dt: Supply bindings for ST's Mailbox IP
  mailbox: Add support for ST's Mailbox IP

 .../devicetree/bindings/mailbox/sti-mailbox.txt    |  66 ++
 arch/arm/boot/dts/stih407-family.dtsi              |  67 +++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-sti.c                      | 664 +++++++++++++++++++++
 include/linux/mailbox_sti.h                        | 128 ++++
 6 files changed, 934 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
 create mode 100644 drivers/mailbox/mailbox-sti.c
 create mode 100644 include/linux/mailbox_sti.h

-- 
1.9.1
