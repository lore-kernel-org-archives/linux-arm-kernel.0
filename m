From: jim2101024@gmail.com (Jim Quinlan)
Date: Mon, 15 Jan 2018 18:28:45 -0500
Subject: [PATCH v4 8/8] MIPS: BMIPS: Enable PCI
In-Reply-To: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
Message-ID: <1516058925-46522-9-git-send-email-jim2101024@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the Kconfig hooks to enable the Broadcom STB PCIe root complex
driver for Broadcom MIPS systems.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990..fe17361 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -210,6 +210,9 @@ config BMIPS_GENERIC
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
+	select HW_HAS_PCI
+	select PCI_DRIVERS_GENERIC
+	select PCI
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYNC_R4K
-- 
1.9.0.138.g2de3478
