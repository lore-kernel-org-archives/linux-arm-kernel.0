From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 28 Feb 2014 14:14:23 +0900
Subject: [PATCH v3 0/2] arm64: prerequisites for audit and ftrace
In-Reply-To: <1393319683-2707-1-git-send-email-takahiro.akashi@linaro.org>
References: <1393319683-2707-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1393564465-3862-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains some patches commonly used by audit and ftrace.

Patch [1/2] defines system call related TIF_* flags to add syscall_trace()
hooks, including ftrace, audit and seccomp, later.
Those features will be implemented in separate patchsets, but it's safe to
check for all TIF_* now because they can not be turned on anyway.

Patch [2/2] adds a function which returns a return value of system call.

Changes v1 -> v2:
* added a guard against TIF_SYSCALL_TRACE at tracehook_report_syscall_*()
* renamed _TIF_WORK_SYSCALL to _TIF_SYSCALL_WORK

Changes v2 -> v3:
* reverted a change in syscall_trace() in v1 [1/2]
* added "arm64: Add regs_return_value() in syscall.h" patch which was
  previously included in audit patch [2/2]

AKASHI Takahiro (2):
  arm64: make a single hook to syscall_trace() for all syscall features
  arm64: Add regs_return_value() in syscall.h

 arch/arm64/include/asm/ptrace.h      |    5 +++++
 arch/arm64/include/asm/thread_info.h |   13 +++++++++++++
 arch/arm64/kernel/entry.S            |    5 +++--
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
1.7.9.5
