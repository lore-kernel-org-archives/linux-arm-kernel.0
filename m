From: tabbott@ksplice.com (Tim Abbott)
Date: Wed, 30 Sep 2009 17:25:33 -0400
Subject: [PATCH v4 0/2] Linker script cleanup patches for arm
Message-ID: <1254345935-15958-1-git-send-email-tabbott@ksplice.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an updated version of the patch series I sent in late July
cleaning up the arm architecture's linker scripts.  Version 2 was
rebased on top of Linus's current master; version 3 contains a fix for
a problem with CONFIG_XIP_KERNEL noted by Russell King.  Version 4
differs from version 3 only in being rebased on top of Linus' master.

This cross-architecture linker script cleanup project is in
preparation for adding support for building the kernel with
-ffunction-sections -fdata-sections, which is a prerequisite for
Ksplice.

	-Tim Abbott

Nelson Elhage (1):
  arm: Clean up linker script using new linker script macros.

Tim Abbott (1):
  arm: convert to use __HEAD and HEAD_TEXT macros.

 arch/arm/kernel/head-nommu.S  |    2 +-
 arch/arm/kernel/head.S        |    2 +-
 arch/arm/kernel/vmlinux.lds.S |   83 ++++++++++++-----------------------------
 3 files changed, 26 insertions(+), 61 deletions(-)
