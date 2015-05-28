From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 28 May 2015 21:46:20 +0200
Subject: [PATCH] ARM: footbridge: enable dc21285 mtd map in defconfig
In-Reply-To: <20150528192238.GQ27753@ld-irv-0074>
References: <20150528192238.GQ27753@ld-irv-0074>
Message-ID: <1432842380-4187-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver fails to build since release 3.2. Improve compile coverage
by enabling this driver in the footbridge defconfig

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/configs/footbridge_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 87e020f303ab..9aebf4b910ca 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -37,6 +37,10 @@ CONFIG_IRDA_CACHE_LAST_LSAP=y
 CONFIG_IRDA_FAST_RR=y
 CONFIG_IRDA_DEBUG=y
 CONFIG_WINBOND_FIR=m
+CONFIG_MTD=m
+CONFIG_MTD_CFI=m
+CONFIG_MTD_COMPLEX_MAPPINGS=y
+CONFIG_MTD_DC21285=m
 CONFIG_PARPORT=y
 CONFIG_PARPORT_PC=y
 CONFIG_PARPORT_PC_FIFO=y
-- 
2.1.4
