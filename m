From: PeterHuewe@gmx.de (Peter =?iso-8859-1?q?H=FCwe?=)
Date: Tue, 29 Jun 2010 00:05:20 +0200
Subject: Subject: [PATCH] arm: fix KConfig warning for mach-mx25
Message-ID: <201006290005.20875.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe at gmx.de

This patch fixes a KConfig warning:
"arch/arm/mach-mx25/Kconfig:18:warning: choice value used outside its
choice group"

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20100628
 arch/arm/mach-mx25/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx25/Kconfig b/arch/arm/mach-mx25/Kconfig
index 3a6668e..2f436ed 100644
--- a/arch/arm/mach-mx25/Kconfig
+++ b/arch/arm/mach-mx25/Kconfig
@@ -15,8 +15,7 @@ choice
 	default MACH_EUKREA_MBIMXSD_BASEBOARD
 
 config MACH_EUKREA_MBIMXSD_BASEBOARD
-	prompt "Eukrea MBIMXSD development board"
-	bool
+	bool "Eukrea MBIMXSD development board"
 	help
 	  This adds board specific devices that can be found on Eukrea's
 	  MBIMXSD evaluation board.
-- 
1.7.1
