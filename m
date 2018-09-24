From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 24 Sep 2018 11:40:09 +0200
Subject: [PATCH 2/2] arm64: freescale: Fix EEPROM unit addresses
In-Reply-To: <20180924094009.19344-1-thierry.reding@gmail.com>
References: <20180924094009.19344-1-thierry.reding@gmail.com>
Message-ID: <20180924094009.19344-2-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

These unit addresses have always been wrong, but DTC only recently
started complaining about it.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 440e111651d5..a59b48203688 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -57,12 +57,12 @@
 		reg = <0x4c>;
 	};
 
-	eeprom at 56 {
+	eeprom at 52 {
 		compatible = "atmel,24c512";
 		reg = <0x52>;
 	};
 
-	eeprom at 57 {
+	eeprom at 53 {
 		compatible = "atmel,24c512";
 		reg = <0x53>;
 	};
-- 
2.19.0
