From: anup.patel@broadcom.com (Anup Patel)
Date: Tue, 22 Aug 2017 15:26:49 +0530
Subject: [PATCH v3 00/17] Broadcom SBA-RAID driver improvements
Message-ID: <1503395827-19428-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does various improvments to Broadcom SBA-RAID
driver.

The patches are based on Linux-4.13-rc3 and can also be found
at sba-raid-imp-v3 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v2:
 - Update patch description for PATCH1 and PATCH3
 - Add dev_err() for debugfs API failures instead of bailing out
 - Add PATCH17 to remove redundant SBA_REQUEST_STATE_COMPLETED

Changes since v1:
 - Split PATCH1 into 10 smaller patches for easier review
 - Added more info to commit description of PATCH2
 - Split PATCH4 into 2 patches for easier review
 - Dropped PATCH6 because it is now part of
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1456425.html

Anup Patel (17):
  dmaengine: bcm-sba-raid: Minor improvments in comments
  dmaengine: bcm-sba-raid: Reduce locking context in sba_alloc_request()
  dmaengine: bcm-sba-raid: Common flags for sba_request state and fence
  dmaengine: bcm-sba-raid: Remove redundant next_count from sba_request
  dmaengine: bcm-sba-raid: Remove redundant resp_dma from sba_request
  dmaengine: bcm-sba-raid: Remove reqs_free_count from sba_device
  dmaengine: bcm-sba-raid: Allow arbitrary number free sba_request
  dmaengine: bcm-sba-raid: Increase number of free sba_request
  dmaengine: bcm-sba-raid: Improve sba_issue_pending() run duration
  dmaengine: bcm-sba-raid: Alloc resources before registering DMA device
  dmaengine: bcm-sba-raid: Peek mbox when we have no free requests
  dmaengine: bcm-sba-raid: Pre-ack async tx descriptor
  dmaengine: bcm-sba-raid: Re-factor sba_process_deferred_requests()
  dmaengine: bcm-sba-raid: Remove redundant SBA_REQUEST_STATE_RECEIVED
  dmaengine: bcm-sba-raid: Add debugfs support
  dmaengine: bcm-sba-raid: Explicitly ACK mailbox message after sending
  dmaengine: bcm-sba-raid: Remove redundant SBA_REQUEST_STATE_COMPLETED

 drivers/dma/bcm-sba-raid.c | 538 ++++++++++++++++++++++++---------------------
 1 file changed, 292 insertions(+), 246 deletions(-)

-- 
2.7.4
