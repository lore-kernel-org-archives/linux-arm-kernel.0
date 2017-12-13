From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 13 Dec 2017 20:37:15 +0100
Subject: [PATCH 2/2] arm: dts: sun8i: a83t: Add an unit address to the memory
 node
In-Reply-To: <20171213193715.31039-1-clabbe.montjoie@gmail.com>
References: <20171213193715.31039-1-clabbe.montjoie@gmail.com>
Message-ID: <20171213193715.31039-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will fix the following warning:
Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 715719f9ea2e..bddde0141f24 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -160,7 +160,7 @@
 		};
 	};
 
-	memory {
+	memory at 40000000 {
 		reg = <0x40000000 0x80000000>;
 		device_type = "memory";
 	};
-- 
2.13.6
