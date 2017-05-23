From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 23 May 2017 16:17:06 +0200
Subject: [PATCH] ARM: dts: moxart: rename sdhci mmc
Message-ID: <1495549026-5805-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The host driver compatible string changed to "moxa,moxart-mmc" during
the review process while the old name was committed to moxart's dts* files.

Correct the host driver compatible string and also fix the node name.

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Applies to next-20170518

 arch/arm/boot/dts/moxart-uc7112lx.dts | 2 +-
 arch/arm/boot/dts/moxart.dtsi         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/moxart-uc7112lx.dts b/arch/arm/boot/dts/moxart-uc7112lx.dts
index 4a962a2..59d8775 100644
--- a/arch/arm/boot/dts/moxart-uc7112lx.dts
+++ b/arch/arm/boot/dts/moxart-uc7112lx.dts
@@ -80,7 +80,7 @@
 	clocks = <&ref12>;
 };
 
-&sdhci {
+&mmc {
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index e86f8c9..54a3ca2 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -91,8 +91,8 @@
 			clocks = <&clk_apb>;
 		};
 
-		sdhci: sdhci at 98e00000 {
-			compatible = "moxa,moxart-sdhci";
+		mmc: mmc at 98e00000 {
+			compatible = "moxa,moxart-mmc";
 			reg = <0x98e00000 0x5C>;
 			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_apb>;
-- 
1.8.2.1
