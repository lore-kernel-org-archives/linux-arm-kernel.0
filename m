From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:52 +0200
Subject: [PATCH v2 10/11] rtlwifi: don't add include path for rtl8188ee
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-11-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For rtl8188ee, we pass -Idrivers/net/wireless/rtlwifi/ to gcc,
however that directy no longer exists, so evidently this option
is no longer required here and can be removed to avoid a warning
when building with 'make W=1' or 'gcc -Wmissing-include-dirs'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile
index a85419a37651..676e7de27f27 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/Makefile
@@ -12,4 +12,4 @@ rtl8188ee-objs :=		\
 
 obj-$(CONFIG_RTL8188EE) += rtl8188ee.o
 
-ccflags-y += -Idrivers/net/wireless/rtlwifi -D__CHECK_ENDIAN__
+ccflags-y += -D__CHECK_ENDIAN__
-- 
2.9.0
