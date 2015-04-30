From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 30 Apr 2015 19:55:30 -0300
Subject: [PATCH 3/3] ARM: dts: imx6sl-warp: Fix OTG roles
In-Reply-To: <1430434530-12605-1-git-send-email-festevam@gmail.com>
References: <1430434530-12605-1-git-send-email-festevam@gmail.com>
Message-ID: <1430434530-12605-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

USBOTG1 always work on peripheral mode and USBOTG in host mode, so fix
their roles accordingly.

Tested by mounting the MMC card as a storage device:

modprobe g_mass_storage file=/dev/mmcblk0p2

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index cec189a..0da906b 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -87,12 +87,13 @@
 };
 
 &usbotg1 {
-	dr_mode = "host";
+	dr_mode = "peripheral";
 	disable-over-current;
 	status = "okay";
 };
 
 &usbotg2 {
+	dr_mode = "host";
 	disable-over-current;
 	status = "okay";
 };
-- 
1.9.1
