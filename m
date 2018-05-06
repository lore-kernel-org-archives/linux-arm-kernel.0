From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  6 May 2018 15:43:49 +0200
Subject: [PATCH 4/7] ARM: dts: Fix the DNS-313 flash compatible
In-Reply-To: <20180506134352.2637-1-linus.walleij@linaro.org>
References: <20180506134352.2637-1-linus.walleij@linaro.org>
Message-ID: <20180506134352.2637-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flash on the DNS-313 needs to be probed as JEDEC, it does
not conform to the common CFI standard.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index 2d9aa5ba8320..d865cde8ed12 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -157,8 +157,12 @@
 
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
2.17.0
