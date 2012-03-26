From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 26 Mar 2012 16:52:55 +0000
Subject: [PATCH] ARM: kirkwood: fdt: use IEEE1275 status = "okay".
In-Reply-To: <4F70991E.1000204@freescale.com>
References: <4F70991E.1000204@freescale.com>
Message-ID: <1332780775-3694-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 - This should prevent others from making the same mistake I did when searching
   the code.

 arch/arm/boot/dts/kirkwood-dreamplug.dts |    2 +-
 drivers/of/base.c                        |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index a5376b8..7b2b961 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -18,7 +18,7 @@
 	ocp at f1000000 {
 		serial at 12000 {
 			clock-frequency = <200000000>;
-			status = "ok";
+			status = "okay";
 		};
 	};
 };
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 133908a..31eac15 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -285,6 +285,7 @@ int of_device_is_available(const struct device_node *device)
 		return 1;
 
 	if (statlen > 0) {
+		/* new boards should use "okay" according to IEEE1275 */
 		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
 			return 1;
 	}
-- 
1.7.3.4
