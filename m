From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 May 2016 23:56:07 +0800
Subject: [PATCH 2/6] ARM: dts: axp209: Disable ldo5 by default
In-Reply-To: <1463500571-28970-1-git-send-email-wens@csie.org>
References: <1463500571-28970-1-git-send-email-wens@csie.org>
Message-ID: <1463500571-28970-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The output pin of LDO is also a GPIO pin, and the on/off settings of the
regulator are actually pinmux settings.

Disable it by default so it doesn't conflict with GPIO usage.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp209.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 051ab3ba9a65..afbe89c01df5 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -87,6 +87,7 @@
 
 		reg_ldo5: ldo5 {
 			regulator-name = "ldo5";
+			status = "disabled";
 		};
 	};
 
-- 
2.8.1
