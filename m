From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 18:26:30 +0100
Subject: [PATCH 0/2] arm64: Use static keys for CPU features
Message-ID: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is aimed to optimise the arm64 cpus_have_cap() functionality
(checking for the presence of certain CPU capabilities/features) to
avoid a bitmap test and use a jump label instead, patched at boot time.

While this series may not provide a clear performance improvement with
the current kernel, it will be more beneficial with new features like
TTBR0 PAN are which are used on hot paths (get_user/put_user, thread
switching).

Catalin Marinas (2):
  jump_labels: Allow array initialisers
  arm64: Use static keys for CPU features

 Documentation/static-keys.txt       |  8 ++++++++
 arch/arm64/include/asm/cpufeature.h | 14 +++++++++++---
 arch/arm64/kernel/cpufeature.c      |  3 +++
 arch/arm64/kernel/cpuinfo.c         |  6 ++++++
 include/linux/jump_label.h          | 12 ++++++++++++
 5 files changed, 40 insertions(+), 3 deletions(-)
