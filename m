From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 15 May 2018 11:13:34 -0600
Subject: [PATCH 0/3] coresight: Don't use contextID with PID namespaces 
Message-ID: <1526404417-32507-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the in-kernel value of a PID differs from what is seen from 
PID namespaces, using contextID tracing with PID namespaces makes the
feature confusing to use and potentially subject to leaking out internal
kernel information.

This set returns an error if contextID and PID namespaces are used in
conjunction and gets rid of the vpid-to-pid translation function as it
is no longer needed.

Thanks,
Mathieu

Mathieu Poirier (3):
  coresight: etm3x: Don't use contextID with PID namespaces
  coresight: etm4x: Don't use contextID with PID namespaces
  coresight: Remove function coresight_vpid_to_pid()

 drivers/hwtracing/coresight/coresight-etm.h        |  3 --
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 43 +++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm3x.c      |  4 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 47 +++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h      |  3 --
 include/linux/coresight.h                          | 20 ---------
 6 files changed, 76 insertions(+), 44 deletions(-)

-- 
2.7.4
