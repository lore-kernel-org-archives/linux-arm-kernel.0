From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Thu, 10 Sep 2015 10:31:18 +0200
Subject: [PATCH v2 2/5] dts: sunxi: correct vendor prefix on OLinuXino a10s
 micro
In-Reply-To: <1441873881-3665-1-git-send-email-o.schinagl@ultimaker.com>
References: <1441873881-3665-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1441873881-3665-3-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The OLinuXino A10S micro features an eeprom. According to the eeprom.txt
binding document, we should use the manufacturer and 'at' is not the
proper manufacturer id according to the vendor-prefixes.

This patch takes the proper vendor-prefix and uses it for the eeprom
node.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index a7e19e4..49a1be6 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -104,7 +104,7 @@
 	status = "okay";
 
 	at24 at 50 {
-		compatible = "at,24c16";
+		compatible = "atmel,24c16";
 		pagesize = <16>;
 		reg = <0x50>;
 		read-only;
-- 
2.1.4
