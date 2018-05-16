From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 16 May 2018 12:01:02 +0100
Subject: [PATCH 05/14] ARM: spectre: add Kconfig symbol for CPUs vulnerable to
 Spectre
In-Reply-To: <20180516105949.GJ16141@n2100.armlinux.org.uk>
References: <20180516105949.GJ16141@n2100.armlinux.org.uk>
Message-ID: <E1fIuB4-0003pm-SW@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig symbol for CPUs which are vulnerable to the Spectre
attacks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 7f14acf67caf..8a5a1bb415c4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -415,6 +415,7 @@ config CPU_V7
 	select CPU_CP15_MPU if !MMU
 	select CPU_HAS_ASID if MMU
 	select CPU_PABRT_V7
+	select CPU_SPECTRE
 	select CPU_THUMB_CAPABLE
 	select CPU_TLB_V7 if MMU
 
@@ -826,6 +827,9 @@ config CPU_BPREDICT_DISABLE
 	help
 	  Say Y here to disable branch prediction.  If unsure, say N.
 
+config CPU_SPECTRE
+	bool
+
 config TLS_REG_EMUL
 	bool
 	select NEED_KUSER_HELPERS
-- 
2.7.4
