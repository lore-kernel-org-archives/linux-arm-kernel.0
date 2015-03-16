From: agraf@suse.de (Alexander Graf)
Date: Mon, 16 Mar 2015 17:32:21 +0100
Subject: [PATCH 0/2] arm64: Allow AArch32 on arm64 with 64k PAGE_SIZE
Message-ID: <1426523543-4124-1-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With binutils 2.25 the default alignment for 32bit arm sections changed to
have everything 64k aligned. Armv7 binaries built with this binutils version
run successfully on an arm64 system with this patch set applied.

This provides the best of both worlds for some users. You get less page faults,
but can still run legacy broken code that might not be 64bit safe yet.

If you want to give this a try, you obviously need user space that was compiled
with 64k constraints fulfilled. For a working rootfs, just grab the latest
openSUSE Factory tree:

  http://download.opensuse.org/ports/armv7hl/factory/images/openSUSE-Factory-ARM-JeOS.armv7-rootfs.armv7l-Current.tbz

Alex

Alexander Graf (1):
  arm64: Enable CONFIG_COMPAT also for 64k page size

Andreas Schwab (1):
  arm64: fix implementation of mmap2 compat syscall

 arch/arm64/Kconfig                |  6 +++++-
 arch/arm64/include/asm/unistd32.h |  2 +-
 arch/arm64/kernel/entry32.S       | 18 ++++++++++++++++++
 arch/arm64/kernel/sys32.c         |  6 ++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

-- 
2.1.4
