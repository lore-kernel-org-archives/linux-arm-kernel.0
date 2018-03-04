From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  4 Mar 2018 14:17:49 +0100
Subject: [PATCH] ARM: dts: Fix the DNS-313 flash compatible
Message-ID: <20180304131749.32065-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flash on the DNS-313 needs to be probed as JEDEC, it does
not conform to the common CFI standard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 5fb3ea8bf300..189ffa1e7c31 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -159,8 +159,12 @@
 
 	soc {
 		flash at 30000000 {
+			/*
+			 * This is a Eon EN29LV400AB 512 KiB flash with
+			 * three partitions.
+			 */
+			compatible = "cortina,gemini-flash", "jedec-flash";
 			status = "okay";
-			/* 512KB of flash */
 			reg = <0x30000000 0x00080000>;
 
 			/*
-- 
2.14.3
