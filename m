From: mike.leach@linaro.org (Mike Leach)
Date: Tue, 11 Jul 2017 12:25:48 +0100
Subject: [PATCH 0/3] drivers: coresight: Adds return stack option handling.
Message-ID: <1499772351-2210-1-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trace return stack is a PTM and ETMv4 programmable option to reduce the
amount of trace genrated by omitting addresses from the trace stream
and inferring them from a local stack of return address values saved when
branch and link instructions are traced.

Adds 'retstack' as a command line option to cs_etm event in perf.
Adds support to program PTM / ETMv4 hardware to use feature.

Mike Leach (3):
  coresight: pmu:  Adds return stack option to perf coresight pmu
  coresight: ptm: Adds trace return stack option programming for PTM.
  coresight: etm4x: Adds trace return stack option programming for
    ETMv4.

 drivers/hwtracing/coresight/coresight-etm-perf.c |  2 ++
 drivers/hwtracing/coresight/coresight-etm.h      |  1 +
 drivers/hwtracing/coresight/coresight-etm3x.c    | 18 +++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.c    |  4 ++++
 include/linux/coresight-pmu.h                    |  1 +
 tools/include/linux/coresight-pmu.h              |  1 +
 6 files changed, 24 insertions(+), 3 deletions(-)

-- 
2.7.4
