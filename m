From: anders.roxell@linaro.org (Anders Roxell)
Date: Tue, 21 Apr 2015 17:05:53 +0200
Subject: [PATCH 0/2] arm64: make it possible to enable threadirqs
Message-ID: <1429628755-22492-1-git-send-email-anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset makes it possible to pass "threadirqs" on the CONFIG_CMDLINE to
make IRQs threaded.
This is safe to use now because all timer interrupts and the perf interrupt are
marked NO_THREAD.

NOTE: I had to add this patch [1] to be able to test this on a juno board.
Without this patch, I see unhandled IRQs in mainline. However, it is unclear
whether or not this will be the actual fix that appears in mainline [2].

Cheers,
Anders

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/319901.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322251.html

Anders Roxell (2):
  arm64: Mark PMU interrupt IRQF_NO_THREAD
  arm64: Allow forced irq threading

 arch/arm64/Kconfig             | 1 +
 arch/arm64/kernel/perf_event.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.1.4
