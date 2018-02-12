From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 12 Feb 2018 13:32:34 -0700
Subject: [PATCH 0/3] perf tools: Miscellaneous fix from the previous cycle
Message-ID: <1518467557-18505-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good day Arnaldo,

Here are 3 patches that were sent late in the v4.15 cycle, too late for
you to pick up for the v4.16 cycle.  I don't know if they are on a backlog
of yours somewhere or if you've made a mental note of them - if so kindly
disregard this set.  Otherwise, here they are again, rebased to your latest
perf/core [1].

All 3 patches are required for proper functionning of the CoreSight
trace decoding integration that is in the current cycle.

Regards,
Mathieu

[1]. f13c88d836d8 perf report: Add support to display group output for non group events

Jin Yao (1):
  perf util: Use target->per_thread and target->system_wide flags

Mathieu Poirier (2):
  perf tools: Freeing allocated memory
  perf tools: Fixing uninitialised variable

 tools/perf/arch/arm/util/auxtrace.c |  2 +-
 tools/perf/util/cs-etm.c            |  6 ++++++
 tools/perf/util/evlist.c            | 21 ++++++++++++++++++++-
 tools/perf/util/thread_map.c        |  4 ++--
 tools/perf/util/thread_map.h        |  2 +-
 5 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.7.4
