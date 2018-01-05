From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  5 Jan 2018 15:30:05 +0100
Subject: [PATCH v2 5/6] ARM: configs: at91: sama5: unselect ATMEL_PIT
In-Reply-To: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
References: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
Message-ID: <20180105143006.5369-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PIT is not required anymore to successfully boot and may actually harm
in case preempt-rt is used because the PIT interrupt is shared.
Disable it so the TCB clocksource is used.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 81594322f3a0..e6b984f18002 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -198,6 +198,7 @@ CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
 CONFIG_AT_XDMAC=y
+# CONFIG_ATMEL_PIT is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
-- 
2.15.1
