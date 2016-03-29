From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 30 Mar 2016 00:30:45 +0200
Subject: [PATCH 6/7] ARM: dts: lpc4337-ciaa:: fix unit name warning from dtc
In-Reply-To: <1459290646-3592-1-git-send-email-manabian@gmail.com>
References: <1459290646-3592-1-git-send-email-manabian@gmail.com>
Message-ID: <1459290646-3592-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning from dtc by either adding a unit name
to the memory node.

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc4337-ciaa.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
index 5cfadb0..7c16d63 100644
--- a/arch/arm/boot/dts/lpc4337-ciaa.dts
+++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
@@ -30,7 +30,7 @@
 		stdout-path = &uart2;
 	};
 
-	memory {
+	memory at 28000000 {
 		device_type = "memory";
 		reg = <0x28000000 0x0800000>; /* 8 MB */
 	};
-- 
2.7.4
