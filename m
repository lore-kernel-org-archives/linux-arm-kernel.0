From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 25 Nov 2016 10:05:49 +0530
Subject: [PATCH 0/2] Broadcom FlexRM ring manager support
Message-ID: <1480048551-3285-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Broadcom FlexRM ring manager provides producer-consumer style
ring interface for offload engines on Broadcom iProc SoCs. We can
have one or more instances of Broadcom FlexRM ring manager in a SoC.

This patchset adds a mailbox driver for Broadcom FlexRM ring manager
which can be used by offload engine drivers as mailbox clients.

The Broadcom FlexRM mailbox driver is feature complete for RAID and
Crypto offload engines. We will have incremental patches in-future
for ring-level statistics using debugfs and minor optimizations.

This patchset is based on Linux-4.9-rc6 and it is also available
at flexrm-v1 branch of https://github.com/Broadcom/arm64-linux.git

Anup Patel (2):
  mailbox: Add driver for Broadcom FlexRM ring manager
  dt-bindings: Add DT bindings info for FlexRM mailbox driver

 .../bindings/mailbox/brcm,flexrm-mbox.txt          |  60 ++
 drivers/mailbox/Kconfig                            |  11 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-flexrm/Makefile            |   6 +
 drivers/mailbox/mailbox-flexrm/flexrm-desc.c       | 764 +++++++++++++++++++
 drivers/mailbox/mailbox-flexrm/flexrm-desc.h       |  47 ++
 drivers/mailbox/mailbox-flexrm/flexrm-main.c       | 829 +++++++++++++++++++++
 include/linux/mailbox/brcm-message.h               |  12 +-
 8 files changed, 1727 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,flexrm-mbox.txt
 create mode 100644 drivers/mailbox/mailbox-flexrm/Makefile
 create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.c
 create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.h
 create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-main.c

-- 
2.7.4
