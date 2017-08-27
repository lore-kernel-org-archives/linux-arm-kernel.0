From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 27 Aug 2017 21:03:07 +0900
Subject: [PATCH 2/2] arm64: dts: uniphier: fix size of sdctrl node
In-Reply-To: <1503835387-9815-1-git-send-email-yamada.masahiro@socionext.com>
References: <1503835387-9815-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1503835387-9815-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All registers are located within 0x400 size from the base address.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index f4948d0aa348..a29c279b6e8e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -320,7 +320,7 @@
 		sdctrl at 59810000 {
 			compatible = "socionext,uniphier-ld20-sdctrl",
 				     "simple-mfd", "syscon";
-			reg = <0x59810000 0x800>;
+			reg = <0x59810000 0x400>;
 
 			sd_clk: clock {
 				compatible = "socionext,uniphier-ld20-sd-clock";
-- 
2.7.4
