From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 23 Jan 2016 23:06:28 +0900
Subject: [PATCH] bus: uniphier-system-bus: revive tristate prompt
Message-ID: <1453557988-2874-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At first, commit 4b7f48d395a7 ("bus: uniphier-system-bus: add UniPhier
System Bus driver") introduced this driver as a tristate one.

Then, commit 326ea45aa827 ("bus: uniphier: allow only built-in
driver") temporarily made it boolean in order to fix a link error
in case it is compiled as a module.

The root cause was fixed by commit b80443c2211c ("of/platform: export
of_default_bus_match_table").

Now this driver can really be a module.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 129d47b..9a92c07 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -132,7 +132,7 @@ config SUNXI_RSB
 	  and AC100/AC200 ICs.
 
 config UNIPHIER_SYSTEM_BUS
-	bool "UniPhier System Bus driver"
+	tristate "UniPhier System Bus driver"
 	depends on ARCH_UNIPHIER && OF
 	default y
 	help
-- 
1.9.1
