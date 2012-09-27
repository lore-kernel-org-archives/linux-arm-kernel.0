From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 27 Sep 2012 15:48:51 +1000
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120927154851.4ec680a2d4a9c4999db5b39d@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/include/asm/timex.h between commit 56942fec06ef ("ARM: 7538/1:
delay: add registration mechanism for delay timer sources") from the arm
tree and commit 387798b37c8d ("ARM: initial multiplatform support") from
the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/include/asm/timex.h
index 9acc135,963342a..0000000
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@@ -12,9 -12,19 +12,13 @@@
  #ifndef _ASMARM_TIMEX_H
  #define _ASMARM_TIMEX_H
  
 -#include <asm/arch_timer.h>
+ #ifdef CONFIG_ARCH_MULTIPLATFORM
+ #define CLOCK_TICK_RATE 1000000
+ #else
  #include <mach/timex.h>
+ #endif
  
  typedef unsigned long cycles_t;
 -
 -#ifdef ARCH_HAS_READ_CURRENT_TIMER
  #define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
 -#else
 -#define get_cycles()	(0)
 -#endif
  
  #endif
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120927/156292f6/attachment.sig>
