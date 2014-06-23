From: vbridgers2013@gmail.com (Vince Bridgers)
Date: Sun, 22 Jun 2014 19:31:02 -0500
Subject: [PATCH 2/2] ARM: socfpga: Add missing #reset-cells to socfpga device
 tree
In-Reply-To: <1403483462-21082-1-git-send-email-vbridgers2013@gmail.com>
References: <1403483462-21082-1-git-send-email-vbridgers2013@gmail.com>
Message-ID: <1403483462-21082-3-git-send-email-vbridgers2013@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add #reset-cells to socfpga.dtsi. This was missing from the
latest updates and caused the socfpga reset controller to fail
to load like so:

ffd05000.rstmgr: /soc/rstmgr at ffd05000 missing #reset-cells property
probe of ffd05000.rstmgr failed with error -22

Signed-off-by: Vince Bridgers <vbridgers2013@gmail.com>
---
 arch/arm/boot/dts/socfpga.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 4676f25..0a66d8a 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -683,6 +683,7 @@
 		};
 
 		rst: rstmgr at ffd05000 {
+			#reset-cells = <1>;
 			compatible = "altr,rst-mgr";
 			reg = <0xffd05000 0x1000>;
 		};
-- 
1.7.9.5
