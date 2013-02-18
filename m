From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 18 Feb 2013 17:07:58 +0530
Subject: [PATCH, RFC 4/8] ARM: am33xx: ll debug config help
In-Reply-To: <cover.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
Message-ID: <bfe941adb98a5000c2817f9fd6160070e59e53c9.1361186097.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting DEBUG_AM33XXUART1 routes low level debug messages to first
UART instance of AM335x based SoC's. This selection is valid for
upcoming AM43 based SoC's too. Make this information available upon
configuring.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/Kconfig.debug | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..b717b78 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -542,6 +542,9 @@ choice
 
 	config DEBUG_AM33XXUART1
 		bool "AM33XX UART1"
+		help
+		  Route low level debug messages to first uart instance
+		  for boards based on am335 and am43 family of SoC's
 
 	config DEBUG_ZOOM_UART
 		bool "Zoom2/3 UART"
-- 
1.7.12
