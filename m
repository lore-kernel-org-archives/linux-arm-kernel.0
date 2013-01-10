From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Jan 2013 13:15:14 +0100
Subject: [PATCH] arm: mvebu: Fix memory size for Armada 370 DB
In-Reply-To: <1357820114-16855-1-git-send-email-gregory.clement@free-electrons.com>
References: <1357820114-16855-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1357820114-16855-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually the Armada 370 DB (aka DB-88F6710-BP-DDR3) come with 1GB and
not 512MB.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 0004402..9b82fac 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -26,7 +26,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x00000000 0x20000000>; /* 512 MB */
+		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
 	soc {
-- 
1.7.9.5
