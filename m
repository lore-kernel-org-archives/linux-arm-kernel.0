From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Sep 2016 11:07:07 +0100
Subject: [PATCH 0/3] arm64: alternative: add auto-nop support
Message-ID: <1473242830-26246-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases where we use pairs of alternative sequences, only one sequence
does valuable work, and the other consists solely of NOPs. We have to manually
ensure that both sequences are the same size, and some NOP sleds are partially
contained unddef ifdefs.

Maintaining this balance is tedious, and the presence of these makes the code
more painful to read than is necessary. These patches add helpers to handle
these cases automatically, making the code more maintainable, and easier to
read.

Thanks,
Mark.

Mark Rutland (3):
  arm64: alternative: add auto-nop infrastructure
  arm64: use alternative auto-nop
  arm64/kvm: use alternative auto-nop

 arch/arm64/include/asm/alternative.h | 71 +++++++++++++++++++++++++++---------
 arch/arm64/include/asm/kvm_mmu.h     | 10 ++---
 arch/arm64/kernel/entry.S            | 10 +----
 arch/arm64/kvm/hyp.S                 |  6 +--
 arch/arm64/lib/copy_page.S           | 13 ++-----
 arch/arm64/mm/proc.S                 |  9 +----
 6 files changed, 66 insertions(+), 53 deletions(-)

-- 
1.9.1
