From: rafalo@cadence.com (Rafal Ozieblo)
Date: Thu, 13 Apr 2017 14:39:58 +0100
Subject: [PATCH 4/4] net: macb: Add macb_ptp to compilation chain
In-Reply-To: <1492090439-11793-1-git-send-email-rafalo@cadence.com>
References: <1492090439-11793-1-git-send-email-rafalo@cadence.com>
Message-ID: <1492090798-16253-1-git-send-email-rafalo@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macb_ptp.c to Makefile.
In case that macb is compiled as a module, it has been renamed to
cadence-macb.ko to avoid naming confusion in Makefile.

Signed-off-by: Rafal Ozieblo <rafalo@cadence.com>
---
 drivers/net/ethernet/cadence/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/Makefile b/drivers/net/ethernet/cadence/Makefile
index 4ba7559..a7f6e04 100644
--- a/drivers/net/ethernet/cadence/Makefile
+++ b/drivers/net/ethernet/cadence/Makefile
@@ -1,6 +1,11 @@
 #
 # Makefile for the Atmel network device drivers.
 #
+cadence-macb-y	:= macb.o
 
-obj-$(CONFIG_MACB) += macb.o
+ifeq ($(CONFIG_MACB_USE_HWSTAMP),y)
+cadence-macb-y	+= macb_ptp.o
+endif
+
+obj-$(CONFIG_MACB) += cadence-macb.o
 obj-$(CONFIG_MACB_PCI) += macb_pci.o
-- 
2.4.5
