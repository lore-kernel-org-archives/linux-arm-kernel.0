From: Russ.Dill@ti.com (Russ Dill)
Date: Tue, 17 Sep 2013 05:43:36 -0700
Subject: [RFC PATCH 10/11] ARM: OMAP2+: AM33XX: Add PIE support for AM33XX
In-Reply-To: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <1379421817-15759-11-git-send-email-Russ.Dill@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables CONFIG_PIE for omap2plus_defconfig and adds
an am33xx PIE section group. This is necessary for am33xx
suspend/resume code as it is written in C.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 arch/arm/kernel/pie.lds.S            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5d4c9b8..f342f85 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -102,6 +102,7 @@ CONFIG_SENSORS_TSL2550=m
 CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_BMP085_I2C=m
 CONFIG_SRAM=y
+CONFIG_PIE=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
diff --git a/arch/arm/kernel/pie.lds.S b/arch/arm/kernel/pie.lds.S
index 4fd5ac5..92fba61 100644
--- a/arch/arm/kernel/pie.lds.S
+++ b/arch/arm/kernel/pie.lds.S
@@ -23,6 +23,7 @@ SECTIONS
 
 	PIE_OVERLAY_START
 	OVERLAY : NOCROSSREFS {
+		PIE_OVERLAY_SECTION(am33xx)
 	}
 	PIE_OVERLAY_SEND
 
-- 
1.8.3.2
