From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 29 Mar 2017 11:00:52 +0530
Subject: [PATCH v7 0/3] Broadcom FlexRM ring manager support
Message-ID: <1490765455-8556-1-git-send-email-anup.patel@broadcom.com>
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

This patchset is based on Linux-4.11-rc4 and it is also available
at flexrm-v7 branch of https://github.com/Broadcom/arm64-linux.git

Changes since v6:
 - Rebased patches for Linux-4.11-rc4
 - Added a patch to remove depends on COMPILE_TEST for kconfig
   option BCM_FLEXRM_MBOX

Changes since v5:
 - Rebased patches for Linux-4.11-rc2
 - Merged all source files into one source file and removed
   driver directory

Changes since v4:
 - Rebased patches for Linux-4.11-rc1

Changes since v3:
 - Fixed mailbox client example DT node in DT bindings document

Changes since v2:
 - Rebased patches for Linux-4.10-rc2

Changes since v1:
 - Use compatile string as brcm,iproc-flexrm-mbox
 - Rephrase commit message and text in DT bindings patch

Anup Patel (3):
  mailbox: Add driver for Broadcom FlexRM ring manager
  dt-bindings: Add DT bindings info for FlexRM ring manager
  mailbox: Remove depends on COMPILE_TEST for BCM_FLEXRM_MBOX

 .../bindings/mailbox/brcm,iproc-flexrm-mbox.txt    |   59 +
 drivers/mailbox/Kconfig                            |   11 +
 drivers/mailbox/Makefile                           |    2 +
 drivers/mailbox/bcm-flexrm-mailbox.c               | 1595 ++++++++++++++++++++
 include/linux/mailbox/brcm-message.h               |   14 +-
 5 files changed, 1677 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-flexrm-mbox.txt
 create mode 100644 drivers/mailbox/bcm-flexrm-mailbox.c

-- 
2.7.4
