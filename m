From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 21:21:59 +0200
Subject: [PATCH 10/11] ARM: OC_ETM should not select ARM_AMBA
In-Reply-To: <1317496920-7764-1-git-send-email-arnd@arndb.de>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
Message-ID: <1317496920-7764-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CONFIG_ARM_AMBA symbol is selected by the platforms that support
AMBA, and the other platforms (e.g. orion) might not be able to
build that code at all when they do not support the clk API.

Instead, make sure that OC_ETM is only built on platforms that
do support the amba subsystem already.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 81cbe40..0c7a4f5 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -94,7 +94,7 @@ config DEBUG_ICEDCC
 
 config OC_ETM
 	bool "On-chip ETM and ETB"
-	select ARM_AMBA
+	depends on ARM_AMBA
 	help
 	  Enables the on-chip embedded trace macrocell and embedded trace
 	  buffer driver that will allow you to collect traces of the
-- 
1.7.5.4
