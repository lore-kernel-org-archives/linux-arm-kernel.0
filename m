From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Tue, 27 Feb 2018 17:34:05 -0500
Subject: [RFC 0/3] perf stat: improvements for handling of multiple PMUs
Message-ID: <1519770848-26738-1-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches adds some simple improvements to the way perf stat
handles PMUs that have multiple instances by:

1. Adding glob-like matching in addition to the prefix-based matching
   introduced previously (patch 1).
2. Adding the ability to recover the PMU names when printing the events
   separately with the --no-merge option (patch 2).
3. Restoring auto-merge for events created by prefix or glob-like match
   (patch 3). Note that this still keeps the behavior that disables
   auto-merging of legacy symbolic events (e.g. cycles).

Agustin Vega-Frias (3):
  perf, tools: Support wildcards on pmu name in dynamic pmu events
  perf, tools: Display pmu name when printing unmerged events in stat
  perf pmu: Restore auto-merging of PMU events created by prefix match

 tools/perf/builtin-stat.c      | 29 ++++++++++++++++++++++++++++-
 tools/perf/util/evsel.c        |  1 +
 tools/perf/util/evsel.h        |  1 +
 tools/perf/util/parse-events.c | 21 ++++++++++-----------
 tools/perf/util/parse-events.h |  2 +-
 tools/perf/util/parse-events.l |  2 +-
 tools/perf/util/parse-events.y |  7 ++++---
 7 files changed, 46 insertions(+), 17 deletions(-)

--
2.7.4
