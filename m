From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 11 Jan 2010 18:44:06 +0900
Subject: [PATCH 1/3] ARM: SAMSUNG: Add config option for number of additional
	GPIO pins.
Message-ID: <1263203046-29219-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a configuration option for specifing the number
of additional GPIO pins to be used in addition to the GPIO pins
supported onchip.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/Kconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 900b463..faec4b8 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -66,6 +66,14 @@ config S3C_GPIO_PULL_UP
 	help
 	  Internal configuration to enable the correct GPIO pull helper
 
+config SAMSUNG_GPIO_EXTRA
+	int "Number of additional GPIO pins"
+	default 0
+	help
+	  Use additional GPIO space in addition to the GPIO's the SOC
+	  provides. This allows expanding the GPIO space for use with
+	  GPIO expanders.
+
 # device definitions to compile in
 
 config S3C_DEV_HSMMC
-- 
1.6.2.5
