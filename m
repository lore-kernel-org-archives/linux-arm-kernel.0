From: robert.walker@arm.com (Robert Walker)
Date: Wed, 14 Feb 2018 11:24:38 +0000
Subject: [PATCH v2 0/3] Perf inject for ETM trace
Message-ID: <1518607481-4059-1-git-send-email-robert.walker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add support for using perf inject to generate branch events,
instruction events and branch stacks from CoreSight ETM traces.

They apply to linus's tree with the memory cleanup fix from
https://lkml.org/lkml/2018/1/25/432

Changes since v1:
 * Split documentation update into separate patch
 * Added null pointer check
 * Moved some changes from patch 2 to patch 1

Regards

Rob Walker

Robert Walker (3):
  perf tools: inject capabilitity for CoreSight traces
  perf inject: Emit instruction records on ETM trace discontinuity
  coresight: Update documentation for perf usage

 Documentation/trace/coresight.txt               |  51 +++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  74 +++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   2 +
 tools/perf/util/cs-etm.c                        | 472 +++++++++++++++++++++---
 4 files changed, 533 insertions(+), 66 deletions(-)

-- 
2.7.4
