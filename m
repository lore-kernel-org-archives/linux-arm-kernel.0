From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 8 Aug 2013 15:43:29 +0800
Subject: [PATCH 1/1] arm: imx: Kconfig: select syscon for mx25
Message-ID: <1375947809-11694-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to use syscon to map one register region for several
devices, eg, usb non-core register for all usb devices.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f546560..5bb21fe 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -109,6 +109,7 @@ config SOC_IMX25
 	select COMMON_CLK
 	select CPU_ARM926T
 	select MXC_AVIC
+	select MFD_SYSCON
 
 config SOC_IMX27
 	bool
-- 
1.7.1
