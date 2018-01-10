From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Jan 2018 17:29:02 +0100
Subject: [PATCH] ARM: bL_switcher: add MODULE_LICENSE tag
Message-ID: <20180110162911.461577-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this tag, we get a build warning:

WARNING: modpost: missing MODULE_LICENSE() in arch/arm/common/bL_switcher_dummy_if.o

For completeness, I'm also adding author and description fields.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/common/bL_switcher_dummy_if.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/common/bL_switcher_dummy_if.c b/arch/arm/common/bL_switcher_dummy_if.c
index 4c10c6452678..f4dc1714a79e 100644
--- a/arch/arm/common/bL_switcher_dummy_if.c
+++ b/arch/arm/common/bL_switcher_dummy_if.c
@@ -57,3 +57,7 @@ static struct miscdevice bL_switcher_device = {
 	&bL_switcher_fops
 };
 module_misc_device(bL_switcher_device);
+
+MODULE_AUTHOR("Nicolas Pitre <nico@linaro.org>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("big.LITTLE switcher dummy user interface");
-- 
2.9.0
