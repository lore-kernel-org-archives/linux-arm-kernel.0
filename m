From: opendmb@gmail.com (Doug Berger)
Date: Wed, 29 Mar 2017 17:29:13 -0700
Subject: [PATCH v3 5/6] bus: brcmstb_gisb: enable driver for ARM64 architecture
In-Reply-To: <20170330002914.7371-1-opendmb@gmail.com>
References: <20170330002914.7371-1-opendmb@gmail.com>
Message-ID: <20170330002914.7371-6-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM64 architecture can provide meaningful diagnostic
output from the GISB arbiter solely from interrupts and
notifiers without the need to hook the low level fault
handlers.

Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 0a52da439abf..d2a5f1184022 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -57,7 +57,7 @@ config ARM_CCN
 
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
-	depends on ARM || MIPS
+	depends on ARM || ARM64 || MIPS
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  Driver for the Broadcom Set Top Box System-on-a-chip internal bus
-- 
2.12.0
