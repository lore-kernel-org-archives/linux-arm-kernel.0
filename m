From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 30 Jun 2017 11:41:54 -0600
Subject: [PATCH 0/5] coresight: Miscellaneous fixes 
Message-ID: <1498844519-8845-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These 5 patches address a few issues we've seen with the drivers as
we keep adding new features.  The first 3 patches address a
synchronisation problem when trace buffers overflow while the latter
two fix a couple of problems when working ETMv3 tracers.

Regards,
Mathieu

Mathieu Poirier (5):
  coresight: Correct buffer lost increment
  coresight: etb10: Remove useless conversion to LE
  coresight: Add barrier packet for synchronisation
  coresight: etb10: Move etb_disable_hw() outside of lock
  coresight: etm3x: Set synchronisation frequencty to TRM default

 drivers/hwtracing/coresight/coresight-etb10.c   | 46 +++++++++++++++++--------
 drivers/hwtracing/coresight/coresight-etm3x.c   |  2 ++
 drivers/hwtracing/coresight/coresight-priv.h    |  2 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 34 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 +++++++
 drivers/hwtracing/coresight/coresight.c         |  8 +++++
 6 files changed, 87 insertions(+), 17 deletions(-)

-- 
2.7.4
