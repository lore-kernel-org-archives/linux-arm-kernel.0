From: serveralex@gmail.com (=?UTF-8?q?Alexander=20M=C3=BCller?=)
Date: Tue, 10 May 2016 22:08:39 +0200
Subject: [PATCH 5/6] ARM: DTS: Amlogic: Enable ethernet on meson8b
In-Reply-To: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
Message-ID: <1462910920-5462-6-git-send-email-serveralex@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethernet to meson8b devicetree.

Signed-off-by: Alexander M?ller <serveralex@gmail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 8ef2da8..a62fba9 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -210,5 +210,16 @@
 				};
 			};
 		};
+
+		ethmac: ethernet at c9410000 {
+			compatible = "amlogic,meson6-dwmac", "snps,dwmac";
+			reg = <0xc9410000 0x10000
+				0xc1108108 0x4>;
+			interrupts = <0 8 1>;
+			interrupt-names = "macirq";
+			clocks = <&clkc CLKID_ETHERNET>;
+			clock-names = "stmmaceth";
+			status = "disabled";
+		};
 	};
 }; /* end of / */
-- 
2.5.0
