From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Tue, 21 Apr 2015 14:05:18 +0200
Subject: [PATCH v2 7/7] ARM: at91/dt: at91-kizbox: update chosen node
In-Reply-To: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
References: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1429617918-32086-8-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the bootargs since the platform is booting from an initramfs and
set the kernel stdout path to DBGU.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index e739104..b567b5f 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -15,7 +15,8 @@
 	compatible = "overkiz,kizbox", "atmel,at91sam9g20", "atmel,at91sam9";
 
 	chosen {
-		bootargs = "panic=5 ubi.mtd=1 rootfstype=ubifs root=ubi0:root";
+		bootargs = "ubi.mtd=ubi";
+		linux,stdout-path = &dbgu;
 	};
 
 	memory {
-- 
1.9.1
