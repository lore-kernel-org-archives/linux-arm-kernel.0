From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Apr 2018 14:54:08 +0530
Subject: [PATCH v2 2/2] ARM: dts: da850-lcdk: add unit name for memory node
In-Reply-To: <20180418092408.2077-1-nsekhar@ti.com>
References: <20180418092408.2077-1-nsekhar@ti.com>
Message-ID: <20180418092408.2077-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add unit name for memory node to squash the W=1 warning:

arch/arm/boot/dts/da850-lcdk.dtb: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

While at it, drop the device_type property from memory
node since its provided by da850.dtsi already.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
v2: drop device_type property. Add a comment on size of SDRAM.

 arch/arm/boot/dts/da850-lcdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index a1f4d6d5a569..0edf769ea95c 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -21,8 +21,8 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
-		device_type = "memory";
+	memory at c0000000 {
+		/* 128 MB DDR2 SDRAM @ 0xc0000000 */
 		reg = <0xc0000000 0x08000000>;
 	};
 
-- 
2.16.2
