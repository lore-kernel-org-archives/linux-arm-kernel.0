From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Nov 2012 13:14:47 +0000
Subject: [PATCH 1/2] ARM: ux500: Disable the MMCI gpio-regulator by default
Message-ID: <1352985288-29518-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not all supported boards will require a MMCI gpio-regulator,
therefore it's a good idea to only enable the node when and if
it is required. Let's disable it by default.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 7ce45fc..d8ba489 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -642,6 +642,8 @@
 			gpio-enable = <&tc3589x_gpio 17 0x4>;
 			states = <1800000 0x1
 				  2900000 0x0>;
+
+			status = "disabled";
 		};
 	};
 };
-- 
1.7.9.5
