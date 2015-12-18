From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Fri, 18 Dec 2015 12:00:33 -0500
Subject: [PATCH 2/2] ARM: dts: TS-4800: add touchscreen support
In-Reply-To: <1450458033-30471-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1450458033-30471-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <1450458033-30471-2-git-send-email-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the touchscreen on TS-4800, using the ts4800-ts
driver.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 arch/arm/boot/dts/imx51-ts4800.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
index 4951ebd..e5e9bd1 100644
--- a/arch/arm/boot/dts/imx51-ts4800.dts
+++ b/arch/arm/boot/dts/imx51-ts4800.dts
@@ -166,6 +166,12 @@
 				syscon = <&syscon 0xe>;
 			};
 		};
+
+		touchscreen {
+			compatible = "technologic,ts4800-ts";
+			reg = <0x12000 0x1000>;
+			syscon = <&syscon 0x10 6>;
+		};
 	};
 };
 
-- 
2.5.0
