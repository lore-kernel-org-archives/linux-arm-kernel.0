From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  5 Jul 2016 06:04:08 +0200
Subject: [PATCH 1/3] ARM: dts: imx6sx-sabreauto: Fix misspelled property
In-Reply-To: <1467691450-22975-1-git-send-email-afaerber@suse.de>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
Message-ID: <1467691450-22975-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit 99fc5ba0bfb6 ("ARM: dts: imx6sx: add i.mx6sx sabreauto board
support") it should've been enable-sdio-wakeup (not -wakup). But that is
now considered a legacy name for wakeup-source, so directly use the new
name instead, as done in commit 26cefdd15db1 for the other occurrence.

Fixes: 26cefdd15db1 ("ARM: dts: imx: replace legacy wakeup property with 'wakeup-source'")
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 96ea936eeeb0..240a2864d044 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -64,7 +64,7 @@
 	cd-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
 	no-1-8-v;
 	keep-power-in-suspend;
-	enable-sdio-wakup;
+	wakeup-source;
 	status = "okay";
 };
 
-- 
2.6.6
