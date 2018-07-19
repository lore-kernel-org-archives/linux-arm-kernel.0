From: labbott@redhat.com (Laura Abbott)
Date: Thu, 19 Jul 2018 16:28:04 -0700
Subject: [PATCHv2 0/2] Stackleak for arm64
In-Reply-To: <1531341400-12077-1-git-send-email-alex.popov@linux.com>
Message-ID: <20180719232806.3397-1-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is hopefully the final version of the stackleak plugin for arm64.
Acks are appreciated!

Laura Abbott (2):
  arm64: Add stack information to on_accessible_stack
  arm64: Clear the stack

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/processor.h    | 15 ++++++
 arch/arm64/include/asm/sdei.h         |  9 ++--
 arch/arm64/include/asm/stacktrace.h   | 73 ++++++++++++++++++++++-----
 arch/arm64/kernel/entry.S             |  7 +++
 arch/arm64/kernel/process.c           | 17 +++++++
 arch/arm64/kernel/ptrace.c            |  2 +-
 arch/arm64/kernel/sdei.c              | 51 ++++++++++++++++---
 arch/arm64/kernel/stacktrace.c        |  2 +-
 arch/arm64/kvm/hyp/Makefile           |  3 +-
 drivers/firmware/efi/libstub/Makefile |  3 +-
 11 files changed, 156 insertions(+), 27 deletions(-)

-- 
2.17.1
