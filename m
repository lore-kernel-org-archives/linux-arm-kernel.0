From: carlo@caione.org (Carlo Caione)
Date: Sat, 27 Aug 2016 15:43:48 +0200
Subject: [PATCH v3 6/6] ARM64: dts: amlogic: gxbb: Enable NVMEM
In-Reply-To: <1472305428-16874-1-git-send-email-carlo@caione.org>
References: <1472305428-16874-1-git-send-email-carlo@caione.org>
Message-ID: <1472305428-16874-7-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add the NVMEM device node in the DTSI.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 18 ++++++++++++++++++
 drivers/firmware/meson/meson_sm.c           |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index ca428e8..aea8fd6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -105,6 +105,24 @@
 		};
 	};
 
+	efuse: efuse {
+		compatible = "amlogic,meson-gxbb-efuse";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		sn: sn at 14 {
+			reg = <0x14 0x10>;
+		};
+
+		eth_mac: eth_mac at 34 {
+			reg = <0x34 0x10>;
+		};
+
+		bid: bid at 46 {
+			reg = <0x46 0x30>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index bba594e..b0d2549 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -21,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/printk.h>
 #include <linux/types.h>
+#include <linux/sizes.h>
 
 #include <linux/firmware/meson/meson_sm.h>
 
@@ -38,7 +39,7 @@ struct meson_sm_chip {
 };
 
 struct meson_sm_chip gxbb_chip = {
-	.shmem_size		= 0x1000,
+	.shmem_size		= SZ_4K,
 	.cmd_shmem_in_base	= 0x82000020,
 	.cmd_shmem_out_base	= 0x82000021,
 	.cmd = {
-- 
2.7.4
