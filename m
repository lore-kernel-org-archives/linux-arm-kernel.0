From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 21 Oct 2012 16:23:09 +0200
Subject: [PATCH 2/5] net/at91_ether: select MACB in Kconfig
In-Reply-To: <1350829392-3812-1-git-send-email-manabian@gmail.com>
References: <1350829392-3812-1-git-send-email-manabian@gmail.com>
Message-ID: <1350829392-3812-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that HAVE_NET_MACB is gone let's just select MACB to
satisfy the dependecies in at91_ether.

PHYLIB will then by selected by MACB.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 drivers/net/ethernet/cadence/Kconfig  | 2 +-
 drivers/net/ethernet/cadence/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 5d1ea30..f6d0956 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -23,7 +23,7 @@ config ARM_AT91_ETHER
 	tristate "AT91RM9200 Ethernet support"
 	depends on ARM && ARCH_AT91RM9200
 	select NET_CORE
-	select PHYLIB
+	select MACB
 	---help---
 	  If you wish to compile a kernel for the AT91RM9200 and enable
 	  ethernet support, then you should always answer Y to this.
diff --git a/drivers/net/ethernet/cadence/Makefile b/drivers/net/ethernet/cadence/Makefile
index 798b1e0..9068b83 100644
--- a/drivers/net/ethernet/cadence/Makefile
+++ b/drivers/net/ethernet/cadence/Makefile
@@ -2,5 +2,5 @@
 # Makefile for the Atmel network device drivers.
 #
 
-obj-$(CONFIG_ARM_AT91_ETHER) += at91_ether.o macb.o
+obj-$(CONFIG_ARM_AT91_ETHER) += at91_ether.o
 obj-$(CONFIG_MACB) += macb.o
-- 
1.7.12.4
