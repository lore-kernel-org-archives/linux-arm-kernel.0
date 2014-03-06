From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 6 Mar 2014 09:45:55 -0800
Subject: [PATCH 2/6] ARM: restrict BCM_KONA_UART to ARCH_BCM_MOBILE
In-Reply-To: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1394127959-3159-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Low-level debugging using the Broadcom Kona UART only makes sense on the
ARCH_BCM_MOBILE platform and would otherwise prevent ARCH_BCM_63XX from
picking up the right UART implementation by default.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 0531da8e5216..c23f52445308 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -108,7 +108,7 @@ choice
 
 	config DEBUG_BCM_KONA_UART
 		bool "Kernel low-level debugging messages via BCM KONA UART"
-		depends on ARCH_BCM
+		depends on ARCH_BCM_MOBILE
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-- 
1.8.3.2
