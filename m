From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 24 Sep 2018 16:04:40 -0700
Subject: [PATCH i2c-next v2 0/2] i2c: aspeed: Add bus idle waiting logic for
 multi-master use cases
Message-ID: <20180924230442.7732-1-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-master environment, this driver's master cannot know
exactly when peer master sends data to this driver's slave so a
case can be happened that this master tries to send data through
the master_xfer function but slave data from peer master is still
being processed by this driver.

To prevent state corruption in the case, this patch adds checking
if any slave operation is ongoing and it waits up to the timeout
duration before starting a master_xfer operation.

Please review this patch set.

Thanks,

-Jae

Changes since v1:
- Changed define names of timeout related.

Jae Hyun Yoo (2):
  dt-bindings: i2c: aspeed: Add 'idle-wait-timeout-ms' setting
  i2c: aspeed: Add bus idle waiting logic for multi-master use cases

 .../devicetree/bindings/i2c/i2c-aspeed.txt    | 10 ++-
 drivers/i2c/busses/i2c-aspeed.c               | 70 +++++++++++++++----
 2 files changed, 62 insertions(+), 18 deletions(-)

-- 
2.18.0
