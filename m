From: nm@ti.com (Nishanth Menon)
Date: Mon, 27 Aug 2018 19:53:11 -0500
Subject: [PATCH] drivers: mailbox: Make ti-msgmr driver depend on ARCH_K3
Message-ID: <20180828005311.8529-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ti-msgmr driver can support K3 platforms as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Jassi,
Last of the patch series for K3 platform support for secure proxy..

Since we now have ARCH_K3 and Secure proxy support in v4.19-rc1,

The dependent patch to enable the driver when ARCH_K3 is selected.

 drivers/mailbox/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 841c005d8ebb..3eeb12e93e98 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -105,12 +105,12 @@ config STI_MBOX
 
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
