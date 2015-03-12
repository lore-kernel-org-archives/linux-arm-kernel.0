From: stefan@agner.ch (Stefan Agner)
Date: Fri, 13 Mar 2015 00:36:15 +0100
Subject: [PATCH v3 07/12] ARM: imx: depend MXC debug board on 3DS machines
In-Reply-To: <1426203380-7155-1-git-send-email-stefan@agner.ch>
References: <1426203380-7155-1-git-send-email-stefan@agner.ch>
Message-ID: <1426203380-7155-8-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depend the MXC debug board on machines which actually support it.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index c8dffce..d21cb9a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -21,6 +21,7 @@ config MXC_AVIC
 
 config MXC_DEBUG_BOARD
 	bool "Enable MXC debug board(for 3-stack)"
+	depends on MACH_MX27_3DS || MACH_MX31_3DS || MACH_MX35_3DS
 	help
 	  The debug board is an integral part of the MXC 3-stack(PDK)
 	  platforms, it can be attached or removed from the peripheral
-- 
2.3.1
