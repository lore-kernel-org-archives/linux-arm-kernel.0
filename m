From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 18 Jul 2014 01:18:51 -0400
Subject: [PATCH 0/4] basic IPI tracing
Message-ID: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Part of the energy aware scheduler work is concerned by test and
measurement tools such as idlestat[1].  This relies on the ability to
trace wake-up events, mainly IRQs and IPIs.

While IRQs are already well instrumented with tracepoints, IPIs are rather
lacking on that front, and completely invisible on ARM.

This series defines generic IPI tracepoints and adds them to ARM and
ARM64. An attempt at adding them to X86 is also included for comments.

[1] https://wiki.linaro.org/WorkingGroups/PowerManagement/Resources/Tools/Idlestat

diffstat:

 arch/arm/kernel/smp.c      | 72 ++++++++++++++++++++------------
 arch/arm64/kernel/smp.c    | 67 +++++++++++++++++++-----------
 arch/x86/kernel/smp.c      | 16 ++++++++
 include/trace/events/ipi.h | 89 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+), 52 deletions(-)
