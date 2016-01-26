From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jan 2016 12:12:05 +0100
Subject: [PATCH 6/6] ARM: realview: fix up PB11MP flash compat strings
In-Reply-To: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1453806725-4880-7-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two flash memories in the PB11MPCore have their VPP/WP
lines controlled from the system controller add-on in the MTD
subsystem. "arm,versatile-flash" is the first compatible string
to use to get the right support.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb11mp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index da755c9851a7..63d6a051839f 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -230,14 +230,14 @@
 
 	flash0 at 40000000 {
 		/* 2 * 32MiB NOR Flash memory */
-		compatible = "arm,vexpress-flash", "cfi-flash";
+		compatible = "arm,versatile-flash", "cfi-flash";
 		reg = <0x40000000 0x04000000>;
 		bank-width = <4>;
 	};
 
 	flash1 at 44000000 {
 		// 2 * 32MiB NOR Flash memory
-		compatible = "arm,vexpress-flash", "cfi-flash";
+		compatible = "arm,versatile-flash", "cfi-flash";
 		reg = <0x44000000 0x04000000>;
 		bank-width = <4>;
 	};
-- 
2.4.3
