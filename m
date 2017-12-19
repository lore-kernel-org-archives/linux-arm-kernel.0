From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 19 Dec 2017 13:36:37 -0200
Subject: [PATCH 2/2] ARM: dts: ls1021a-twr: Remove extra clock cell
In-Reply-To: <1513697797-22724-1-git-send-email-fabio.estevam@nxp.com>
References: <1513697797-22724-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1513697797-22724-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an extraneous '1' cell in the clock phandle, which causes
the following build warning: 

arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Property 'clocks', cell 1 is not a phandle reference in /soc/i2c at 2190000/sgtl5000 at a
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (clocks_property): Missing property '#clock-cells' in node /soc/interrupt-controller at 1400000 or bad phandle (referred from /soc/i2c at 2190000/sgtl5000 at a:clocks[1])

Remove the unneeded extra cell.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/ls1021a-twr.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
index 3adf793..f0c949d 100644
--- a/arch/arm/boot/dts/ls1021a-twr.dts
+++ b/arch/arm/boot/dts/ls1021a-twr.dts
@@ -187,7 +187,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p3v>;
 		VDDIO-supply = <&reg_3p3v>;
-		clocks = <&sys_mclk 1>;
+		clocks = <&sys_mclk>;
 	};
 };
 
-- 
2.7.4
