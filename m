From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 20 Oct 2015 17:00:17 +0900
Subject: [PATCH v2 0/2] arm64: unwind_frame for interrupt stack
Message-ID: <1445328019-23330-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jungseok is going to introduce a dedicated interrupt stack[1] for arm64.
This patch is my second proposal to support interrupt stack in
unwind_frame() and address an issue I mentioned in [2].

Patch[3] is also a prerequisite.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378699.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/377723.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378700.html

AKASHI Takahiro (2):
  arm64: revamp unwind_frame for interrupt stack
  arm64: fix dump_backtrace() to show correct pt_regs at interrupt

 arch/arm64/include/asm/exception.h |    7 +++----
 arch/arm64/include/asm/traps.h     |    7 -------
 arch/arm64/kernel/entry.S          |   22 ++++++++++++++++++++--
 arch/arm64/kernel/stacktrace.c     |   14 +++++++++++++-
 arch/arm64/kernel/traps.c          |    9 +++++++--
 arch/arm64/kernel/vmlinux.lds.S    |    7 +++++++
 6 files changed, 50 insertions(+), 16 deletions(-)

-- 
1.7.9.5
