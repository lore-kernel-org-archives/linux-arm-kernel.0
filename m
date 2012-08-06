From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  6 Aug 2012 14:23:31 +0200
Subject: [PATCH 3/6] ARM: dove: add crypto engine
In-Reply-To: <1344255815-4457-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344255815-4457-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1344255815-4457-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a dove specific setup function for the Marvell CESA
crypto engine available on orion based SoCs. Dove setup was just
missing a function to call orion_crypto_init with dove specific
setup.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Ian Molton <ian.molton@codethink.co.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Maen Suleiman <maen@marvell.com>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-dove/common.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index e074f1c..6f2fe65 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -263,6 +263,15 @@ struct sys_timer dove_timer = {
 };
 
 /*****************************************************************************
+ * Cryptographic Engines and Security Accelerator (CESA)
+ ****************************************************************************/
+void __init dove_crypto_init(void)
+{
+	orion_crypto_init(DOVE_CRYPT_PHYS_BASE, DOVE_CESA_PHYS_BASE,
+			  DOVE_CESA_SIZE, IRQ_DOVE_CRYPTO);
+}
+
+/*****************************************************************************
  * XOR 0
  ****************************************************************************/
 void __init dove_xor0_init(void)
-- 
1.7.10.4
