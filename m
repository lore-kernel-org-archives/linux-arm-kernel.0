From: mike.leach@linaro.org (Mike Leach)
Date: Mon, 20 Mar 2017 20:36:18 +0000
Subject: [PATCH] documentation: trace: Clarification of perf usage with
 coresight.
Message-ID: <1490042178-2547-1-git-send-email-mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update to the coresight.txt documentation to clarify the specification
of the trace sink when using 'perf record'

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 Documentation/trace/coresight.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index d1033aa..e8af562 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -243,6 +243,12 @@ linaro at linaro-nano:~$ perf record -e cs_etm//u --per-thread <command>
 
 linaro at linaro-nano:~$ perf record -C 0,2-3 -e cs_etm//k <command>
 
+Note that after a trace run, the sink will be disabled, so it must be
+re-enabled before the next 'perf record' command is executed.
+Alternatively the sink may be specified as part of the perf command line:
+
+linaro at linaro-nano:~$ perf record -e cs_etm/@20010000.etb/u --per-thread <command>
+
 As of this writing two ETM/PTM specific options have are available: cycle
 accurate and timestamp (please refer to the Embedded Trace Macrocell reference
 manual for details on these options).  By default both are disabled but using
-- 
2.7.4
