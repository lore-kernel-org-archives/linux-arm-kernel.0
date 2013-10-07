From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  7 Oct 2013 08:48:22 -0700
Subject: [PATCH v2] ARM: tlb: ASID macro should give 32bit result for BE
 correct operation
Message-ID: <1381160903-1248-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Ben, Russell, Thomas,

Please review second version of patch that fixes TLB asid issue in big endian
V7 image.

Changes from v1:
   Note previous patch subject line was 'ARM: tlb: 
   __flush_tlb_mm need to use int asid var for BE correct operation'

   Added 'unsigned int' cast into ASID macro itself rather
   then use intermediate 'int' variable in __flush_tlb_mm function. 
   This is done per v1 patch discussion at

   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/202583.html

Tested with Linaro BE topic branch on Arndale board. Both LE and BE
images were tested.

Thanks,
Victor

Victor Kamensky (1):
  ARM: tlb: ASID macro should give 32bit result for BE correct operation

 arch/arm/include/asm/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.1.4
