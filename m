From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 Dec 2014 11:53:01 +0100
Subject: [PATCH] ARM: config: sama5: Remove DEBUG_LL
Message-ID: <1418208781-10903-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sama5_defconfig can be used both on the sama5d3 and the sama5d4.

Enabling DEBUG_LL is an issue though, since it will by default use the kernel
addresses for the sama5d3 DBGU UART, that is located at a different address on
the sama5d4.

Remove this from the defconfig.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/configs/sama5_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index c9089c927daf..7cdb5b875d4d 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -199,8 +199,6 @@ CONFIG_DEBUG_MEMORY_INIT=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
-CONFIG_DEBUG_LL=y
-CONFIG_EARLY_PRINTK=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
-- 
2.2.0
