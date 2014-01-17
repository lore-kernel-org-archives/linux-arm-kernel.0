From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 17 Jan 2014 17:03:14 +0900
Subject: [PATCH v3] audit: generic compat system call support
In-Reply-To: <1384854235-6567-1-git-send-email-takahiro.akashi@linaro.org>
References: <1384854235-6567-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1389945795-4255-1-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arm64 supports 32-bit mode(AArch32) and 64-bit mode(AArch64).
To enable audit on arm64, we want to use lib/audit.c and re-work it
to support compat system calls as well without copying it under
arch sub-directory.

So this patch is mandatory for my "system call audit support for arm64"
patch. Please review it as well for better understandings.

This code was tested on armv8 fast model with 64-bit and 32-bit userland
by using modified audit-test-code.

Changes v1 -> v2:
* Specify AUDIT_CLASS_XYZ_32 instead of AUDIT_CLASS_XYZ when registering
  compat syscalls (bug fix)


AKASHI Takahiro (1):
  audit: Add generic compat syscall support

 include/linux/audit.h |    9 +++++++++
 lib/Makefile          |    3 +++
 lib/audit.c           |   17 +++++++++++++++++
 lib/compat_audit.c    |   51 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 80 insertions(+)
 create mode 100644 lib/compat_audit.c

-- 
1.7.9.5
