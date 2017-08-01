From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  1 Aug 2017 16:05:49 +0530
Subject: [PATCH v3 0/5] FlexRM driver improvements
Message-ID: <1501583754-31969-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does various improvments to Broadcom FlexRM
mailbox controller driver and also adds FlexRM DT nodes
for Stingray SOC.

The patches are based on Linux-4.13-rc3 and can also be
found at flexrm-imp-v3 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v2:
 - Dropped PATCH5 and PATCH6
 - Added a PATCH to use txdone_ack instead of txdone_poll
 - Dropped PATCH7 because it is now part of
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1456425.html

Changes since v1:
 - Add one more patch to use bitmap instead of IDA in FlexRM driver

Anup Patel (5):
  mailbox: bcm-flexrm-mailbox: Set IRQ affinity hint for FlexRM ring
    IRQs
  mailbox: bcm-flexrm-mailbox: Add debugfs support
  mailbox: bcm-flexrm-mailbox: Fix mask used in CMPL_START_ADDR_VALUE()
  mailbox: bcm-flexrm-mailbox: Use bitmap instead of IDA
  mailbox: bcm-flexrm-mailbox: Use txdone_ack instead of txdone_poll

 drivers/mailbox/bcm-flexrm-mailbox.c | 252 ++++++++++++++++++++++++-----------
 1 file changed, 175 insertions(+), 77 deletions(-)

-- 
2.7.4
