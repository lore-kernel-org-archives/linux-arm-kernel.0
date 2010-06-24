From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 24 Jun 2010 15:49:22 +0200
Subject: [PATCH 26/61] ARM: imx: prepare deprecating ARCH_MX1, MACH_MX2,
	MACH_MX21 and MACH_MX27
In-Reply-To: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1277387397-3467-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1277387397-3467-27-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MACH_... is reserved for machine support, so use SOC as prefix, not MACH.

This introduces new symbols SOC_IMX1, SOC_IMX21 and SOC_IMX27.  They are
selected by the old symbols for now.  There is no substitute for MACH_MX2
as most usages of MX2 only means MX21 + MX27 but not MX25.

Later the choice about CPU and CPU family should go away and the individual
machines should select the right SOC symbol.  This is a precondition to
support more than one SOC in a single kernel image.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 08002df..5edead2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -2,7 +2,6 @@ if ARCH_MX1
 
 config SOC_IMX1
 	select CPU_ARM920T
-	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	bool
 
@@ -28,14 +27,12 @@ if ARCH_MX2
 config SOC_IMX21
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
-	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	bool
 
 config SOC_IMX27
 	select CPU_ARM926T
 	select ARCH_MXC_AUDMUX_V1
-	select IMX_HAVE_DMA_V1
 	select IMX_HAVE_IOMUX_V1
 	bool
 
-- 
1.7.1
