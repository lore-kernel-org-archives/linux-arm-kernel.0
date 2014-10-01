From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 1 Oct 2014 13:37:33 +0300
Subject: [PATCH 3/4] ARM: dts: keystone-k2e: fix mdio io start address
In-Reply-To: <1412159854-21143-1-git-send-email-grygorii.strashko@ti.com>
References: <1412159854-21143-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1412159854-21143-4-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The K2E MDIO io space has different start address.
Hence, fix it to be 0x24200f00 according to TRM.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2e.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/k2e.dtsi b/arch/arm/boot/dts/k2e.dtsi
index 0e25f79..13b0feb 100644
--- a/arch/arm/boot/dts/k2e.dtsi
+++ b/arch/arm/boot/dts/k2e.dtsi
@@ -80,3 +80,7 @@
 		};
 	};
 };
+
+&mdio {
+	reg = <0x24200f00 0x100>;
+};
-- 
1.9.1
