From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 17 Apr 2018 15:31:27 +0530
Subject: [PATCH 2/2] ARM: dts: da850-lcdk: add unit name for memory node
In-Reply-To: <20180417100128.23011-1-nsekhar@ti.com>
References: <20180417100128.23011-1-nsekhar@ti.com>
Message-ID: <20180417100128.23011-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add unit name for memory node to squash the W=1 warning:

arch/arm/boot/dts/da850-lcdk.dtb: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index a1f4d6d5a569..e80839bb071b 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -21,7 +21,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory {
+	memory at c0000000 {
 		device_type = "memory";
 		reg = <0xc0000000 0x08000000>;
 	};
-- 
2.16.2
