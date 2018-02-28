From: colin.king@canonical.com (Colin King)
Date: Wed, 28 Feb 2018 17:38:23 +0000
Subject: [PATCH] ARM: iop13xx: Remove duplicated bit-wise or of
 PCI_STATUS_REC_TARGET_ABORT
Message-ID: <20180228173823.4074-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

Bit pattern PCI_STATUS_REC_TARGET_ABORT is being bit-wise or'd twice;
remove the redundant 2nd PCI_STATUS_REC_TARGET_ABORT

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-iop13xx/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-iop13xx/pci.h b/arch/arm/mach-iop13xx/pci.h
index 736168d8c7ac..c6a0678c1741 100644
--- a/arch/arm/mach-iop13xx/pci.h
+++ b/arch/arm/mach-iop13xx/pci.h
@@ -23,7 +23,6 @@ void iop13xx_map_pci_memory(void);
 #define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_REC_TARGET_ABORT | \
-			       PCI_STATUS_REC_TARGET_ABORT | \
 			       PCI_STATUS_REC_MASTER_ABORT | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
 	 		       PCI_STATUS_DETECTED_PARITY)
-- 
2.15.1
