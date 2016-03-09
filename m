From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  8 Mar 2016 20:48:33 -0700
Subject: [PATCH 0/3] coresight: sysFS conformance and enhancement 
Message-ID: <1457495316-5281-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset works on the registers exported to sysFS by the ETB and
TMC drivers.  For ETB the "status" entry is broken up to present
one register per entry.  On the TMC driver entries are added to 
convey the same information as found on ETB.

To avoid code duplication the "coresight_simple_func()" macro is moved
to a header file and driver specific customisation is done in driver
files.

This set applies on 4.5-rc7 and assumes [1] has been applied.

Best regards,
Mathieu 

[1]. https://lkml.org/lkml/2016/2/29/630

Mathieu Poirier (3):
  coresight: moving coresight_simple_func() to header file
  coresight: etb10: splitting sysFS "status" entry
  coresight: tmc: adding sysFS management entries

 .../ABI/testing/sysfs-bus-coresight-devices-etb10  |  69 +++++++++++--
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  77 +++++++++++++++
 drivers/hwtracing/coresight/coresight-etb10.c      |  86 ++++++++---------
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  33 +++----
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  63 ++++++------
 drivers/hwtracing/coresight/coresight-priv.h       |  10 ++
 drivers/hwtracing/coresight/coresight-tmc.c        | 107 +++++++++------------
 7 files changed, 272 insertions(+), 173 deletions(-)

-- 
2.1.4
