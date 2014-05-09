From: larry.bassel@linaro.org (Larry Bassel)
Date: Fri,  9 May 2014 14:51:48 -0700
Subject: [PATCH v3 0/2] context tracker support for arm64
Message-ID: <1399672310-9061-1-git-send-email-larry.bassel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement and enable context tracking for arm64 (which is
a prerequisite for FULL_NOHZ support). This patchset
builds upon earlier work by Kevin Hilman and is based on 3.15-rc2.

Changes v2 to v3:

* Save/restore necessary registers in ct_user_enter and ct_user_exit
* Annotate "error paths" out of el0_sync with ct_user_exit

Changes v1 to v2:

* Save far_el1 in x26 temporarily

Larry Bassel (2):
  arm64: adjust el0_sync so that a function can be called
  arm64: enable context tracking

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  1 +
 arch/arm64/kernel/entry.S            | 76 ++++++++++++++++++++++++++++++++----
 3 files changed, 70 insertions(+), 8 deletions(-)

-- 
1.8.3.2
