From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Wed,  4 Dec 2013 11:20:19 +0530
Subject: [PATCH v4] ARM64 breakpoint and single step exception hooks
Message-ID: <1386136220-15171-1-git-send-email-sandeepa.prabhu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for breakpoint and single-step exception hooks.

v3 version of this patch is published and reviewed with arm64 kdgb and kprobes patch series [1] and [2]

[1] http://lwn.net/Articles/570648/
[2] https://lwn.net/Articles/571063/

Changes v3 -> v4:
 -Incorporated review comments: http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/207372.html
    -Removed unnecessary comments
    -Added comments for breakpoint re-entrancy & rw locks
 - Rebased on top of git://git.kernel.org/pub/scm/linux/kernel/git/cmarinas/linux-aarch64.git Branch:upstream
commit ID: dc1ccc48159d63eca5089e507c82c7d22ef60839  (Linux 3.13-rc2)
 - CCing Jason Wessel, since arm64 kgdb patchset is dependant on this.

Sandeepa Prabhu (1):
  arm64: support single-step and breakpoint handler hooks

 arch/arm64/include/asm/debug-monitors.h | 21 ++++++++
 arch/arm64/kernel/debug-monitors.c      | 88 ++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/entry.S               |  2 +
 3 files changed, 110 insertions(+), 1 deletion(-)

-- 
1.8.1.2
