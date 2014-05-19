From: ritesh.harjani@gmail.com (ritesh.harjani at gmail.com)
Date: Mon, 19 May 2014 16:04:24 +0530
Subject: [PATCH 0/1] Implement flush_kern_tlb_page
Message-ID: <1400495665-48279-1-git-send-email-ritesh.harjani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

This patch adds the function definition to
flush_kern_tlb_page, defined in comments header in
arch/arm64/include/asm/tlbflush.h

>From ARMv8_arm: 
TLBI VAE1IS: Global TLB entries that match the VA value will be affected by this operation,
regardless of the value of the ASID field.


So, since kernel region has nG(non-Global) == 0, means region is available for
all processes. So, we can use TLBI VAE1IS for kernel region as well. 

Ritesh Harjani (1):
  arm64: TLB maintainance: Implement flush_kern_tlb_page

 arch/arm64/include/asm/tlbflush.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
1.8.1.3
