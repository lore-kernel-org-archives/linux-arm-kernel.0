From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue,  2 Jul 2013 20:02:27 +0400
Subject: [PATCH 4/6] ARM: dts: imx27-phytec-phycore-som: Add SRAM node
In-Reply-To: <1372780949-31897-1-git-send-email-shc_work@mail.ru>
References: <1372780949-31897-1-git-send-email-shc_work@mail.ru>
Message-ID: <1372780949-31897-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SRAM node for Phytec PCM-038 module.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 92765ee..bd7df2e 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -181,4 +181,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	sram: sram at c8000000 {
+		compatible = "mtd-ram";
+		reg = <1 0x00000000 0x00800000>;
+		bank-width = <2>;
+		linux,mtd-name = "mtd-ram.0";
+		fsl,weim-cs-timing = <0x0000d843 0x22252521 0x22220a00>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
 };
-- 
1.8.1.5
