From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 12:53:27 +0200
Subject: [PATCH 4/6] ide: drop dependency on ARCH_SHARK
Message-ID: <1379069607-4184-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This drops the selection of default IDE chipset for the Shark
machine as it has been deleted.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hi David, I am seeking an ACK to take this through the ARM SoC
tree as part of the deletion of the Shark machine. Please do not
apply it to your tree.
---
 drivers/ide/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 02906ca..3f7f59c 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -197,8 +197,8 @@ comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
-	depends on ALPHA || X86 || IA64 || M32R || MIPS || ARCH_RPC || ARCH_SHARK
-	default ARM && (ARCH_RPC || ARCH_SHARK)
+	depends on ALPHA || X86 || IA64 || M32R || MIPS || ARCH_RPC
+	default ARM && ARCH_RPC
 	help
 	  This is the generic IDE driver.  This driver attaches to the
 	  fixed legacy ports (e.g. on PCs 0x1f0/0x170, 0x1e8/0x168 and
-- 
1.8.3.1
