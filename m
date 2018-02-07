From: robert.walker@arm.com (Robert Walker)
Date: Wed,  7 Feb 2018 13:56:00 +0000
Subject: [PATCH 0/2] Perf inject for ETM trace
Message-ID: <1518011762-23925-1-git-send-email-robert.walker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add support for using perf inject to generate branch events,
instruction events and branch stacks from CoreSight ETM traces.

They apply to linus's tree with the memory cleanup fix from
https://lkml.org/lkml/2018/1/25/432

Regards

Rob Walker

Robert Walker (2):
  perf tools: inject capabilitity for CoreSight traces
  perf inject: Emit instruction records on ETM trace discontinuity

 Documentation/trace/coresight.txt               |  51 +++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  74 +++-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   2 +
 tools/perf/util/cs-etm.c                        | 471 +++++++++++++++++++++---
 4 files changed, 532 insertions(+), 66 deletions(-)

-- 
2.7.4
