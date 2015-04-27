From: anders.roxell@linaro.org (Anders Roxell)
Date: Mon, 27 Apr 2015 22:53:07 +0200
Subject: [PATCHv2 0/3] Enable PREEMPT_RT_FULL on arm64
Message-ID: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I tested this on an arm64 juno target, and to get that to boot I
had to backport the dtb from v4.0-rc6 to v3.18.11-rt7.

Incorporated comments from Sebastian Andrzej Siewior and Ayyappa Ch.

Cheers,
Anders

Anders Roxell (3):
  arm64: Mark PMU interrupt IRQF_NO_THREAD
  arm64: Allow forced irq threading
  arch/arm64: Enable PREEMPT_RT_FULL

 arch/arm64/Kconfig                   |  2 ++
 arch/arm64/include/asm/thread_info.h |  3 +++
 arch/arm64/kernel/asm-offsets.c      |  1 +
 arch/arm64/kernel/entry.S            | 13 ++++++++++---
 arch/arm64/kernel/perf_event.c       |  2 +-
 5 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.1.4
