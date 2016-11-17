From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:08:29 +0100
Subject: [PATCH v3 12/13] ARM: dts: armada-375: Fixup memory DT warning
In-Reply-To: <20161117230830.31047-1-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230830.31047-13-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memory has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index 5ed226236398..64edd59486e0 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -58,7 +58,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
-- 
2.10.2
