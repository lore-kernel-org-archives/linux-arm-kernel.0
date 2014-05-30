From: larry.bassel@linaro.org (Larry Bassel)
Date: Fri, 30 May 2014 12:34:13 -0700
Subject: [PATCH v7 0/2] context tracker support for arm64
Message-ID: <1401478455-26391-1-git-send-email-larry.bassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement and enable context tracking for arm64 (which is
a prerequisite for FULL_NOHZ support). This patchset
builds upon earlier work by Kevin Hilman and is based on
Will Deacon's tree.

Changes v6 to v7:

* Rename parameter of ct_user_exit from restore to syscall

Changes v5 to v6:

* Don't save far_el1 in x26 in el0_dbg path (not needed)
* TIF_NOHZ processes go through the slow path (so no register
save/restore is needed in ct_user_enter)

Changes v4 to v5:

* Improvement to code restoring far_el1 (suggested by Christopher Covington)
* Improvement to register save/restore in ct_user_enter

Changes v3 to v4:

* Rename parameter of ct_user_exit from save to restore
* Rebased patch to Will Deacon's tree (branch remotes/origin/aarch64
of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git)

Changes v2 to v3:

* Save/restore necessary registers in ct_user_enter and ct_user_exit
* Annotate "error paths" out of el0_sync with ct_user_exit

Changes v1 to v2:

* Save far_el1 in x26 temporarily

Larry Bassel (2):
  arm64: adjust el0_sync so that a function can be called
  arm64: enable context tracking

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  4 +++
 arch/arm64/kernel/entry.S            | 58 +++++++++++++++++++++++++++++++-----
 3 files changed, 56 insertions(+), 7 deletions(-)

-- 
1.8.3.2
