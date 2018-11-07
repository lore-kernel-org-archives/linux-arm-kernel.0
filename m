From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  7 Nov 2018 16:08:48 -0700
Subject: [PATCH v2 0/4] coresight: Fix miscellaneous problems with CLAIM tags
Message-ID: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set addresses problems observed with the CLAIM tag feature.  The first
patch adds support for CLAIM tags to the ETB10 drivers.  The remaining 3 
patches deal with properly handling the tags on ETF and ETM3x devices.

Regards,
Mathieu

Changes since V1:
* Added Suzuki's review tags to patch 1 and 2.
* Addressed ordering issued in ETM3x enable/disable functions (Leo Yan)
 

Mathieu Poirier (4):
  coresight: etb10: Add support for CLAIM tag
  coresight: etf: Release CLAIM tag after disabling the HW
  coresight: etm3x: Deal with CLAIM tag before and after accessing HW
  coresight: etm3x: Release CLAIM tag when operated from perf

 drivers/hwtracing/coresight/coresight-etb10.c   | 23 +++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c   | 17 +++++++++--------
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +-
 3 files changed, 27 insertions(+), 15 deletions(-)

-- 
2.7.4
