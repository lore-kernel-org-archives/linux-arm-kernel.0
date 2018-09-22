From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Sat, 22 Sep 2018 21:09:52 +0530
Subject: [PATCH 1/5] arm64/mm: Use ESR_ELx_FSC macro while decoding fault
 exception
In-Reply-To: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
References: <1537630796-14756-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537630796-14756-2-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just replace hard code value of 63 (0x111111) with an existing macro
ESR_ELx_FSC when parsing for the status code during fault exception.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 50b30ff..75b8794 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -59,7 +59,7 @@ static const struct fault_info fault_info[];
 
 static inline const struct fault_info *esr_to_fault_info(unsigned int esr)
 {
-	return fault_info + (esr & 63);
+	return fault_info + (esr & ESR_ELx_FSC);
 }
 
 #ifdef CONFIG_KPROBES
-- 
2.7.4
