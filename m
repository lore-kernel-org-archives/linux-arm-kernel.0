From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sun, 5 Feb 2017 22:33:13 +0100
Subject: [v5,3/7] rtc: ac100: Add RTC driver for X-Powers AC100
In-Reply-To: <1467988422-17934-4-git-send-email-wens@csie.org>
References: <1467988422-17934-4-git-send-email-wens@csie.org>
Message-ID: <20170205213312.pcoxq2di54ur7ncv@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 10:33:38PM +0800, Chen-Yu Tsai wrote:
> X-Powers AC100 is a codec / RTC combo chip. This driver supports
> the RTC sub-device.

Don't we also want to build this driver by default, at least for
sunxi_defconfig, but possibly for multi_v7_defconfig as well?

-------------------- >8 --------------------
Subject: [PATCH] ARM: sunxi_defconfig: Enable AC100 RTC driver

Enable the AC100 RTC driver so boards with it can keep track of time.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index da92c25..5cd5dd70 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -87,6 +87,7 @@ CONFIG_THERMAL_OF=y
 CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MFD_AC100=y
 CONFIG_MFD_AXP20X=y
 CONFIG_MFD_AXP20X_I2C=y
 CONFIG_MFD_AXP20X_RSB=y
@@ -129,6 +130,7 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_INTF_SYSFS is not set
 # CONFIG_RTC_INTF_PROC is not set
+CONFIG_RTC_DRV_AC100=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_SUNXI=y
 CONFIG_DMADEVICES=y
-- 
2.10.2

-- 
Rask Ingemann Lambertsen
