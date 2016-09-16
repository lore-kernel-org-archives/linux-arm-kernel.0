From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Sep 2016 08:44:02 -0600
Subject: [PATCH V7 0/3] Adding support for address filters 
Message-ID: <1474037045-31730-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set makes it possible to use the current filter
framework with address filters.  That way address filters for
HW tracers such as CoreSight and Intel PT can be communicated
to the kernel drivers.

In this revision precursor work is done to make function
perf_evsel__append_filter() generic, along with changes to
current customers.  From there the work on address filters is
introduced.

Thanks,
Mathieu

---
Changes for V7:
 - s/intelPT/Intel PT
 - Added Adrian's ack.

Changes for V6:
 - Split work in 3 (small) patches.
 - Adding tracepoint and address filter append() functions

Changes for V5:
 - Modified perf_evsel__append_filter() to take a string format
   rather than an operation.

Changes for V4:
 - Added support for address filters over more than one
   nibble.
 - Removed Jiri's ack, this version is too different from
   what was reviewed.

Changes for V3:
 - Added Jiri's ack.
 - Rebased to v4.8-rc5.

Changes for V2:
 - Rebased to v4.8-rc4.
 - Revisited error path.

Mathieu Poirier (3):
  perf tools: making perf_evsel__append_filter() generic
  perf tools: new tracepoint specific function
  perf tools: adding support for address filters

 tools/perf/builtin-trace.c     |  8 ++++++--
 tools/perf/util/evsel.c        | 16 +++++++++++++---
 tools/perf/util/evsel.h        |  5 +++--
 tools/perf/util/parse-events.c | 41 +++++++++++++++++++++++++++++++++++------
 4 files changed, 57 insertions(+), 13 deletions(-)

-- 
2.7.4
