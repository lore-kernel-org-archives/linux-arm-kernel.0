From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 10 May 2013 22:12:27 +0200
Subject: [PATCH] ARM: plat-orion: add missing ehci include to common.h
Message-ID: <1368216747-28898-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing orion ehci include from board files will raise a compiler
error because plat/common.h is using an enum provided by orion ehci
but not including the include itself. This just adds the missing include.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/plat-orion/include/plat/common.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/plat-orion/include/plat/common.h
index e06fc5f..d9a24f6 100644
--- a/arch/arm/plat-orion/include/plat/common.h
+++ b/arch/arm/plat-orion/include/plat/common.h
@@ -10,6 +10,7 @@
 
 #ifndef __PLAT_COMMON_H
 #include <linux/mv643xx_eth.h>
+#include <linux/platform_data/usb-ehci-orion.h>
 
 struct dsa_platform_data;
 struct mv_sata_platform_data;
-- 
1.7.10.4
