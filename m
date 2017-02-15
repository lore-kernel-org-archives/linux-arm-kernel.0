From: ohaugan@codeaurora.org (Olav Haugan)
Date: Tue, 14 Feb 2017 18:20:27 -0800
Subject: [PATCH 0/2] coresight: Replace sprintf with scnprintf + bug fix
Message-ID: <20170215022029.21744-1-ohaugan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replaced all occurrences of s{n}printf with scnprintf for consistency
across coresight files.
While doing that found a bug in one of the show functions which I also
fixed (second patch).

Olav Haugan (2):
  coresight: Replace sprintf with scnprintf
  coresight: etm3x: Correctly output counter values in sysfs node

 drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 80 ++++++++++++----------
 drivers/hwtracing/coresight/coresight-funnel.c     |  4 +-
 drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
 6 files changed, 51 insertions(+), 41 deletions(-)

-- 
2.11.0
