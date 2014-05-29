From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:16 -0500
Subject: [PATCH v2 06/11] dts: versatile: add pl180 compatible strings
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

While not needed for probing, add the "arm,pl180" compatible string for
completeness.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
v2:
- no change
 arch/arm/boot/dts/versatile-ab.dts | 2 +-
 arch/arm/boot/dts/versatile-pb.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 5dc3be7..85c7b2b 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -187,7 +187,7 @@
 				interrupts = <24>;
 			};
 			mmc at 5000 {
-				compatible = "arm,primecell";
+				compatible = "arm,pl180", "arm,primecell";
 				reg = < 0x5000 0x1000>;
 				interrupts-extended = <&vic 22 &sic 2>;
 			};
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 65f6577..a428541 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -39,7 +39,7 @@
 				interrupts = <5>;
 			};
 			mmc at b000 {
-				compatible = "arm,primecell";
+				compatible = "arm,pl180", "arm,primecell";
 				reg = <0xb000 0x1000>;
 				interrupts-extended = <&vic 23 &sic 2>;
 			};
-- 
1.9.1
