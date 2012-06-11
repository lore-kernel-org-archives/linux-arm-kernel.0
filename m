From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 11 Jun 2012 16:25:07 +0100
Subject: [PATCH 14/14] ARM: ux500: Move rtc-pl031 registration to Device Tree
 when enabled
In-Reply-To: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1339428307-3850-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During a Device Tree boot, all probing will now be completed on parse
of the Device Tree binary. In the same patch we remove platform
registration of the Real Time Clock.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi    |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 26f895f..e90a449 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -48,7 +48,7 @@
 		};
 
 		rtc at 80154000 {
-			compatible = "stericsson,db8500-rtc";
+			compatible = "arm,rtc-pl031", "arm,primecell";
 			reg = <0x80154000 0x1000>;
 			interrupts = <0 18 0x4>;
 		};
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 7d5d090..a823993 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -237,7 +237,6 @@ struct device * __init u8500_of_init_devices(void)
 
 	parent = db8500_soc_device_init();
 
-	db8500_add_rtc(parent);
 	db8500_add_usb(parent, usb_db8500_rx_dma_cfg, usb_db8500_tx_dma_cfg);
 	platform_device_register_data(parent,
 		"cpufreq-u8500", -1, NULL, 0);
-- 
1.7.9.5
