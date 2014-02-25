From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 25 Feb 2014 18:14:42 +0900
Subject: [PATCH v2 0/1] arm64: make a single hook to syscall_trace() for all
 syscall features
In-Reply-To: <1391767651-5296-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391767651-5296-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1393319683-2707-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes it easy to add syscall related hooks, including ftrace,
audit and seccomp, in syscall_trace() later.
Those features will be implemented in separate patchsets, but it's safe to
check for all TIF_* now because they can not be turned on anyway.

Changes v1 -> v2:
* added a guard against TIF_SYSCALL_TRACE at tracehook_report_syscall_*()
* renamed _TIF_WORK_SYSCALL to _TIF_SYSCALL_WORK

AKASHI Takahiro (1):
  arm64: make a single hook to syscall_trace() for all syscall features

 arch/arm64/include/asm/thread_info.h |   13 ++++++++++
 arch/arm64/kernel/entry.S            |    5 ++--
 arch/arm64/kernel/ptrace.c           |   45 +++++++++++++++++-----------------
 3 files changed, 38 insertions(+), 25 deletions(-)

-- 
1.7.9.5
