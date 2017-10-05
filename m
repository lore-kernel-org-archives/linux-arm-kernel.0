From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 5 Oct 2017 15:59:14 +0300
Subject: [PATCH] arm64: mm: Clarify a printk in data_abort_decode()
Message-ID: <20171005125914.34uc5qq5titpq6zi@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 0x in front of a base 10 number is misleading so I removed it.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 89993c4be1be..a5382e90418c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -97,7 +97,7 @@ static void data_abort_decode(unsigned int esr)
 			 (esr & ESR_ELx_SF) >> ESR_ELx_SF_SHIFT,
 			 (esr & ESR_ELx_AR) >> ESR_ELx_AR_SHIFT);
 	} else {
-		pr_alert("  ISV = 0, ISS = 0x%08lu\n", esr & ESR_ELx_ISS_MASK);
+		pr_alert("  ISV = 0, ISS = %08lu\n", esr & ESR_ELx_ISS_MASK);
 	}
 
 	pr_alert("  CM = %lu, WnR = %lu\n",
