From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu,  6 Nov 2014 18:22:10 +0100
Subject: [PATCH] ARM: dts: zynq: Enable PL clocks for Parallella
Message-ID: <1415294531-8942-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Parallella board comes with a U-Boot bootloader that loads one of
two predefined FPGA bitstreams before booting the kernel. Both define an
AXI interface to the on-board Epiphany processor.

Enable clocks FCLK0..FCLK3 for the Programmable Logic by default.

Otherwise accessing, e.g., the ESYSRESET register freezes the board,
as seen with the Epiphany SDK tools e-reset and e-hw-rev, using /dev/mem.

Cc: <stable@vger.kernel.org> # 3.17.x
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Michal/Olof, please consider this trivial patch as a fix for 3.18.

 arch/arm/boot/dts/zynq-parallella.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index e1f51ca127fe..0429bbd89fba 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -34,6 +34,10 @@
 	};
 };
 
+&clkc {
+	fclk-enable = <0xf>;
+};
+
 &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
-- 
2.1.2
