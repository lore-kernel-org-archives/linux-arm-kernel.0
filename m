From: jean.pihet@linaro.org (Jean Pihet)
Date: Mon,  7 Jul 2014 15:45:07 +0200
Subject: [PATCH 0/3] ARM: perf: allow tracing with kernel tracepoints events
Message-ID: <1404740710-14691-1-git-send-email-jean.pihet@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Robustify the user backtrace code, as done on other architectures.
- Provide the symbols resolution when triggering from tracepoints.

Big thanks to Steve Capper for the help in debugging and rephrasing the
commits descriptions.

Stress tested with perf record and tracepoints triggering (-e <tracepoint>),
with unwinding using fp (--call-graph fp) and dwarf info (--call-graph dwarf).


Jean Pihet (3):
  ARM: perf: Check that current->mm is alive before getting user
    callchain
  ARM: perf: disable the pagefault handler when reading from user space
  ARM: perf: allow tracing with kernel tracepoints events

 arch/arm/include/asm/perf_event.h | 19 +++++++++++++++++++
 arch/arm/kernel/perf_event.c      | 13 +++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

-- 
1.8.1.2
