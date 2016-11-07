From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  7 Nov 2016 22:41:28 +0100
Subject: [PATCH 3/3] ARM64: dts: marvell: Fixup memory DT warning for Armada
 37xx
In-Reply-To: <20161107214128.18401-1-gregory.clement@free-electrons.com>
References: <20161107214128.18401-1-gregory.clement@free-electrons.com>
Message-ID: <20161107214128.18401-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memory has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts          | 2 +-
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 1372e9a6aaa4..a260ae25b658 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -56,7 +56,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
index eadd5993c7bd..83178d909fc2 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
@@ -55,7 +55,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
 	};
-- 
2.10.1
