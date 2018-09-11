From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 11 Sep 2018 15:52:44 +0800
Subject: [PATCH v2 0/2] CoreSight: tmc-etf: Fixes for updating buffer
Message-ID: <1536652366-17119-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is to two fixing of updating ring buffer in tmc-etf
driver.  The first patch is to fix alignment setting for RRP; the second
patch tries to fix discarding trace data issue caused by filling
barrier packets in the same place, the patch keeps complete trace data
with inserting extra barrier packets.

This patch series has been rebased on CoreSight next branch:
https://git.linaro.org/kernel/coresight.git/log/?h=next with latest
commit 3733ca5a6578 ("coresight: tmc: Refactor loops in etb dump").

Changes from v1:
* Rebased on CoreSight next branch (Sept 11th, 2018);
* Added checking 'lost || to_read > handle->size' to set 'barrier_sz'.


Leo Yan (2):
  coresight: tmc: Fix byte-address alignment for RRP
  coresight: tmc: Fix writing barrier packets for ring buffer

 drivers/hwtracing/coresight/coresight-tmc-etf.c | 41 +++++++++++++++++--------
 1 file changed, 29 insertions(+), 12 deletions(-)

-- 
2.7.4
