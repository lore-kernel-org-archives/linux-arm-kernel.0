From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  6 Mar 2017 15:10:38 +0530
Subject: [PATCH v5 0/2] Broadcom FlexRM ring manager support
Message-ID: <1488793240-25484-1-git-send-email-anup.patel@broadcom.com>
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

This patchset is based on Linux-4.11-rc1 and it is also available
at flexrm-v5 branch of https://github.com/Broadcom/arm64-linux.git

Changes since v4:
 - Rebased patches for Linux-4.11-rc1

Changes since v3:
 - Fixed mailbox client example DT node in DT bindings document

Changes since v2:
 - Rebased patches for Linux-4.10-rc2

Changes since v1:
 - Use compatile string as brcm,iproc-flexrm-mbox
 - Rephrase commit message and text in DT bindings patch

Anup Patel (2):
  mailbox: Add driver for Broadcom FlexRM ring manager
  dt-bindings: Add DT bindings info for FlexRM ring manager

 .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    |  59 ++
 drivers/mailbox/Kconfig                            |  11 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/mailbox-flexrm/Makefile            |   6 +
 drivers/mailbox/mailbox-flexrm/flexrm-desc.c       | 764 +++++++++++++++++++
 drivers/mailbox/mailbox-flexrm/flexrm-desc.h       |  47 ++
 drivers/mailbox/mailbox-flexrm/flexrm-main.c       | 829 +++++++++++++++++++++
 include/linux/mailbox/brcm-message.h               |  14 +-
 8 files changed, 1728 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
 create mode 100644 drivers/mailbox/mailbox-flexrm/Makefile
 create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.c
 create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-desc.h
 create mode 100644 drivers/mailbox/mailbox-flexrm/flexrm-main.c

-- 
2.7.4
