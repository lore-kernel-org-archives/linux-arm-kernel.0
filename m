From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Fri, 23 Feb 2018 18:15:58 +0100
Subject: [PATCH v3 6/6] ARM: configs: at91: unselect PIT
In-Reply-To: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
Message-ID: <20180223171558.7037-7-alexandre.belloni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PIT is not required anymore to successfully boot and may actually harm
in case preempt-rt is used because the PIT interrupt is shared.
Disable it so the TCB clocksource is used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 arch/arm/configs/sama5_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 09f262e59fef..f4b253bd05ed 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -19,6 +19,7 @@ CONFIG_ARCH_MULTI_V5=y
 CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
+# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index f2bbc6339ca6..be92871ab155 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -20,6 +20,7 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
+# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
-- 
2.16.1
