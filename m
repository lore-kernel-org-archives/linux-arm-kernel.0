From: houpengyang@huawei.com (Hou Pengyang)
Date: Fri, 8 May 2015 05:43:02 +0000
Subject: [PATCH v4 0/2] arm & arm64: perf: Fix callchain parse error with
 kernel tracepoint events
Message-ID: <1431063784-137600-1-git-send-email-houpengyang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For arm & arm64, when tracing with tracepoint events, the IP and cpsr 
are set to 0, preventing the perf code parsing the callchain and 
resolving the symbols correctly. 

These two patches fix this by implementing perf_arch_fetch_caller_regs
for arm and arm64, which fills several necessary register info for 
callchain unwinding and symbol resolving.

v3->v4:
 - fix compile errors

v2->v3:
 - split the original patch into two, one for arm and the other arm64;
 - change '|=' to '=' when setting cpsr. 

Hou Pengyang (2):
  arm: perf: Fix callchain parse error with kernel tracepoint events
  arm64: perf: Fix callchain parse error with kernel tracepoint events

 arch/arm/include/asm/perf_event.h   | 7 +++++++
 arch/arm64/include/asm/perf_event.h | 7 +++++++
 2 files changed, 14 insertions(+)

-- 
1.8.3.4
