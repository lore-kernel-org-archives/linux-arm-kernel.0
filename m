From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 09:16:11 +0000
Subject: [PATCH 0/2] IPI numbering cleanup
Message-ID: <1450430173-26992-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Thompson reported[1] that IPI_CPU_BACKTRACE failed to fire on
one of his platforms because SGI15 was already used by the secure
firmware.

In order to move this IPI to the non-secure side, this series drops
IPI_CALL_FUNC_SINGLE (which has been deprecated for a while). This
allows the last non-secure SGI to be reallocated to IPI_CPU_BACKTRACE.

       M.

[1]: https://lkml.org/lkml/2015/12/16/375

Marc Zyngier (2):
  ARM: Remove IPI_CALL_FUNC_SINGLE
  ARM: Make IPI_CPU_BACKTRACE a "non-secure" SGI

 arch/arm/include/asm/hardirq.h |  2 +-
 arch/arm/kernel/smp.c          | 12 ++----------
 2 files changed, 3 insertions(+), 11 deletions(-)

-- 
2.1.4
