From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Feb 2018 17:24:50 +0100
Subject: [PATCH 1/3] ARM: clps711x: mark clps711x_compat as const
Message-ID: <20180220162519.1498223-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The array of string pointers is put in __initconst, and the strings themselves
are marke 'const' but the the pointers are not, which caused a warning when
built with LTO:

arch/arm/mach-clps711x/board-dt.c:72:20: error: 'clps711x_compat' causes a section type conflict with 'feroceon_ids'
 static const char *clps711x_compat[] __initconst = {

This marks the array itself const as well, which was certainly the
intention originally.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-clps711x/board-dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-clps711x/board-dt.c b/arch/arm/mach-clps711x/board-dt.c
index ee1f83b1a332..4c89a8e9a2e3 100644
--- a/arch/arm/mach-clps711x/board-dt.c
+++ b/arch/arm/mach-clps711x/board-dt.c
@@ -69,7 +69,7 @@ static void clps711x_restart(enum reboot_mode mode, const char *cmd)
 	soft_restart(0);
 }
 
-static const char *clps711x_compat[] __initconst = {
+static const char *const clps711x_compat[] __initconst = {
 	"cirrus,ep7209",
 	NULL
 };
-- 
2.9.0
