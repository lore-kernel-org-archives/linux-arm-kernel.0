From: sudaraja@codeaurora.org (Sudarshan Rajagopalan)
Date: Thu, 25 Oct 2018 17:14:36 -0700
Subject: [PATCH] arm64: Log the Fault Status Code (FSC) upon memory aborts
Message-ID: <1540512876-12011-1-git-send-email-sudaraja@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When decoding the information from ESR on mem faults, log the
FSC value, which is commonly shared for Data and Instruction aborts.

Change-Id: If7d7f6027958864d99dfb7e79d368e82415dce97
Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
---
 arch/arm64/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b8eecc7..e9d07ab 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -120,6 +120,7 @@ static void mem_abort_decode(unsigned int esr)
 	pr_alert("  EA = %lu, S1PTW = %lu\n",
 		 (esr & ESR_ELx_EA) >> ESR_ELx_EA_SHIFT,
 		 (esr & ESR_ELx_S1PTW) >> ESR_ELx_S1PTW_SHIFT);
+	pr_alert("  FSC = %lu\n", (esr & ESR_ELx_FSC));
 
 	if (esr_is_data_abort(esr))
 		data_abort_decode(esr);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
