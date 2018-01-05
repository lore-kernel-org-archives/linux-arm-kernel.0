From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  5 Jan 2018 15:30:06 +0100
Subject: [PATCH v2 6/6] ARM: configs: at91: at91_dt unselect ATMEL_PIT
In-Reply-To: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
References: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
Message-ID: <20180105143006.5369-7-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PIT is not required anymore to successfully boot and may actually harm
in case preempt-rt is used because the PIT interrupt is shared.
Disable it so the TCB clocksource is used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 09f262e59fef..3ec7afe7a6c9 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -181,6 +181,7 @@ CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
+# CONFIG_ATMEL_PIT is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
-- 
2.15.1
