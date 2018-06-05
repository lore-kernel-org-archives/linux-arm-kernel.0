From: nm@ti.com (Nishanth Menon)
Date: Tue, 5 Jun 2018 01:16:28 -0500
Subject: [RFC PATCH 7/8] drivers: mailbox: Make ti-msgmr driver depend on
 ARCH_K3
In-Reply-To: <20180605061629.4759-1-nm@ti.com>
References: <20180605061629.4759-1-nm@ti.com>
Message-ID: <20180605061629.4759-8-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ti-msgmr driver can support K3 platforms as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/mailbox/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 725dce5ba62d..f87a857d21a5 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -99,12 +99,12 @@ config STI_MBOX
 
 config TI_MESSAGE_MANAGER
 	tristate "Texas Instruments Message Manager Driver"
-	depends on ARCH_KEYSTONE
+	depends on ARCH_KEYSTONE || ARCH_K3
 	help
 	  An implementation of Message Manager slave driver for Keystone
-	  architecture SoCs from Texas Instruments. Message Manager is a
-	  communication entity found on few of Texas Instrument's keystone
-	  architecture SoCs. These may be used for communication between
+	  and K3 architecture SoCs from Texas Instruments. Message Manager
+	  is a communication entity found on few of Texas Instrument's keystone
+	  and K3 architecture SoCs. These may be used for communication between
 	  multiple processors within the SoC. Select this driver if your
 	  platform has support for the hardware block.
 
-- 
2.15.1
