From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:32 +0200
Subject: [PATCH 51/58] ARM: at91/defconfig: at91_dt unselect ATMEL_PIT
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-52-alexandre.belloni@free-electrons.com>
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
index e4b1be66b3f5..9d068f07b84b 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -182,6 +182,7 @@ CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 CONFIG_AT_HDMAC=y
+# CONFIG_ATMEL_PIT is not set
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
-- 
2.11.0
