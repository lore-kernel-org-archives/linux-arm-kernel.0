From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 29 Apr 2013 21:26:52 +0200
Subject: [PATCH RESEND] ARM: dove: fix Dove cpu type from V7 to PJ4
In-Reply-To: <1364051211-24414-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1364051211-24414-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367263612-17596-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU used in Marvell Dove SoCs is a PJ4 Sheeva core. Using
CONFIG_CPU_PJ4 instead of CONFIG_CPU_V7 will enable iWMMXt
extensions on Dove.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
Note: This patch is rebased on v3.9 and patch message has been modified
to point out that iWMMXt is now enforced on CPU_PJ4.

Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1cacda4..3c5e4da 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -555,7 +555,7 @@ config ARCH_IXP4XX
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select ARCH_REQUIRE_GPIOLIB
-	select CPU_V7
+	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_PCI
 	select PINCTRL
-- 
1.7.10.4
