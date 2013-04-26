From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 26 Apr 2013 10:13:55 +0200
Subject: [PATCH 1/2] ARM: dts: i.MX6: configure L2 cache data and tag latency
Message-ID: <1366964036-17275-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the data and tag latency for the L2 cache. This improves the
system performance.

This configuration is taken from Freescale's kernel patch

"ENGR00153601 [MX6]Adjust L2 cache parameter" [1]

which does

writel(0x132, IO_ADDRESS(L2_BASE_ADDR + L2X0_TAG_LATENCY_CTRL));
writel(0x132, IO_ADDRESS(L2_BASE_ADDR + L2X0_DATA_LATENCY_CTRL));

In this patch we are doing the same via the device tree.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>

[1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/arch/arm/mach-mx6/mm.c?h=imx_3.0.35_12.09.01&id=814656410b40c67a10b25300e51b0477b2bb96d1
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 281a223..3e8381d 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -100,6 +100,8 @@
 			interrupts = <0 92 0x04>;
 			cache-unified;
 			cache-level = <2>;
+			arm,tag-latency = <4 2 3>;
+			arm,data-latency = <4 2 3>;
 		};
 
 		aips-bus at 02000000 { /* AIPS1 */
-- 
1.8.2
