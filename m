From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 19 May 2015 10:55:05 -0600
Subject: [PATCH 00/16] coresight: next v4.1-rc4 
Message-ID: <1432054521-24807-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider the following set for inclusion in your char-misc tree.
It is assumed that this patchset [1] has been previously applied.  Get
back to me if a pull request with all the patches ([1] + these) is easier
for you to handle.

Thanks,
Mathieu

[1]. https://lwn.net/Articles/644285/

Linus Walleij (13):
  coresight: etm: print what version of ETM/PTM is detected
  coresight: support the TPIU version found in Ux500
  coresight: etm: let runtime PM handle core clock
  coresight: tpiu: let runtime PM handle core clock
  coresight: etb: let runtime PM handle core clock
  coresight: funnel: let runtime PM handle core clock
  coresight: tmc: let runtime PM handle core clock
  coresight: etm: retrieve and handle atclk
  coresight: tpiu: retrieve and handle atclk
  coresight: etb: retrieve and handle atclk
  coresight: funnel: retrieve and handle atclk
  coresight: replicator: retrieve and handle atclk
  coresight: document the bindings for the ATCLK

Mathieu Poirier (1):
  coresight-etm3x: use module_amba_driver to simplify the code

Pankaj Dubey (1):
  coresight: fix typo in of_coresight.c

Pratik Patel (1):
  coresight: replicator: Add Qualcomm CoreSight Replicator driver

 .../devicetree/bindings/arm/coresight.txt          |  12 +-
 drivers/hwtracing/coresight/Kconfig                |   8 +
 drivers/hwtracing/coresight/Makefile               |   1 +
 drivers/hwtracing/coresight/coresight-etb10.c      |  72 ++++---
 drivers/hwtracing/coresight/coresight-etm.h        |   4 +-
 drivers/hwtracing/coresight/coresight-etm3x.c      | 112 +++++------
 drivers/hwtracing/coresight/coresight-funnel.c     |  61 ++++--
 .../coresight/coresight-replicator-qcom.c          | 214 +++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-replicator.c |  71 ++++++-
 drivers/hwtracing/coresight/coresight-tmc.c        |  31 +--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  60 ++++--
 drivers/hwtracing/coresight/of_coresight.c         |   2 +-
 12 files changed, 499 insertions(+), 149 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-replicator-qcom.c

-- 
1.9.1
