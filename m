From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Nov 2018 15:26:27 -0700
Subject: [PATCH 0/3] coresight: Fix miscellaneous problems with CLAIM tags 
Message-ID: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set addresses 3 problems observed with the CLAIM tag feature.  The first
patch adds support for CLAIM tags to the ETB10 drivers.  The second and third
patch deal with releasing the tags on ETF and ETM3x devices.

Review and testing would be appreciated.

Regards,
Mathieu

Mathieu Poirier (3):
  coresight: etb10: Add support for CLAIM tag
  coresight: etf: Release CLAIM tag after disabling the HW
  coresight: etm3x: Release CLAIM tag when operated from perf

 drivers/hwtracing/coresight/coresight-etb10.c   | 23 +++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm3x.c   |  2 ++
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.7.4
