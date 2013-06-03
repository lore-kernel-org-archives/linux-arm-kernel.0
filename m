From: marc.ceeeee@gmail.com (Marc C)
Date: Mon, 3 Jun 2013 16:35:59 -0700
Subject: [RFC PATCH] ARM: update legacy CPU ID in decompressor cache support
 jump table
Message-ID: <CAO1A-8AaWyp6eq7c5nkU=KBxwrm1CM3erXcsxLmYpCn2mHhMUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following is a formal RFC PATCH for the suggestion offered by rmk
in this thread:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-January/007871.html

The previous mask values for the legacy ARM CPU IDs were conflicting
with the CPU ID assignments for late-generation CPUs (like the
Qualcomm MSM/QSD or Broadcom Brahma-15 processors). This change
corrects the legacy ARM CPU ID value so that the jump table can
fall-through to the appropriate cache maintenance / MMU functions.

To: linux-arm-kernel at lists.infradead.org
Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
---
 arch/arm/boot/compressed/head.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fe4d9c3..a1b9e83 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -805,8 +805,8 @@ call_cache_fn:      adr     r12, proc_types
                .align  2
                .type   proc_types,#object
 proc_types:
-               .word   0x00000000              @ old ARM ID
-               .word   0x0000f000
+               .word   0x41000000              @ old ARM ID
+               .word   0xff00f000
                mov     pc, lr
  THUMB(                nop                             )
                mov     pc, lr
--
1.7.6
