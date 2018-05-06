From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  6 May 2018 15:43:50 +0200
Subject: [PATCH 5/7] ARM: dts: Fix bootargs for Gemini D-Link devices
In-Reply-To: <20180506134352.2637-1-linus.walleij@linaro.org>
References: <20180506134352.2637-1-linus.walleij@linaro.org>
Message-ID: <20180506134352.2637-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These machines need to be booted from very specific harddisk
partitions (as the D-Link DNS-313 boots specifically from
partition 4). Add the proper bootargs so that everything works
smoothly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 3 ++-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini-dlink-dir-685.dts b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
index 8d3478cf840b..89ce0d1916e3 100644
--- a/arch/arm/boot/dts/gemini-dlink-dir-685.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dir-685.dts
@@ -20,7 +20,8 @@
 	};
 
 	chosen {
-		stdout-path = "uart0:115200n8";
+		bootargs = "console=ttyS0,19200n8 root=/dev/sda1 rw rootwait";
+		stdout-path = "uart0:19200n8";
 	};
 
 	gpio_keys {
diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
index d865cde8ed12..da78a0aa389a 100644
--- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
+++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
@@ -26,6 +26,7 @@
 	};
 
 	chosen {
+		bootargs = "console=ttyS0,19200n8 root=/dev/sda4 rw rootwait";
 		stdout-path = "uart0:19200n8";
 	};
 
-- 
2.17.0
