From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri,  7 Feb 2014 19:11:30 +0900
Subject: [PATCH 0/2] arm64: Add seccomp support
Message-ID: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables secure computing (system call filtering) on arm64.
System calls can be allowed or denied by loaded bpf-style rules.
Architecture specific part is to run secure_computing() on syscall entry
and check the result. See [1/2]

Prerequisites are:
 * "arm64: Add audit support" patch
 * "arm64: make a single hook to syscall_trace() for all syscall features" patch

This code is tested on ARMv8 fast model using libseccomp v2.1.1 with
modifications for arm64 and verified by its "live" tests, 20, 21 and 24.

AKASHI Takahiro (2):
  arm64: Add seccomp support
  arm64: is_compat_task is defined both in asm/compat.h and
    linux/compat.h

 arch/arm64/Kconfig               |   17 +++++++++++++++++
 arch/arm64/include/asm/compat.h  |    2 ++
 arch/arm64/include/asm/seccomp.h |   28 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/unistd.h  |    3 +++
 arch/arm64/kernel/entry.S        |    4 ++++
 arch/arm64/kernel/ptrace.c       |    5 +++++
 6 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/include/asm/seccomp.h

-- 
1.7.9.5
