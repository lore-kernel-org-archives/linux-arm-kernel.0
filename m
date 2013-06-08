From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  8 Jun 2013 18:39:40 +0400
Subject: [PATCH 5/5] ARM: dts: imx27-phytec-phycore-rdk: Add MTD name for NOR
 flash
In-Reply-To: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
References: <1370702380-25408-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370702380-25408-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds name for NOR flash. This keeps compatibility for
commandline partitions parsing from old bootloaders and make name
of device same for DT and non-DT boot.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 73f4b28..f010565 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -57,6 +57,7 @@
 		compatible = "cfi-flash";
 		bank-width = <2>;
 		reg = <0xc0000000 0x02000000>;
+		linux,mtd-name = "physmap-flash.0";
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
-- 
1.8.1.5
