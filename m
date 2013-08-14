From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 14 Aug 2013 11:48:02 -0500
Subject: [PATCHv4 1/3] arm: socfpga: dts: Add a syscon binding for sys-mgr
Message-ID: <1376498884-9199-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The system manager block in SOCFPGA contains registers that control other
IPs in the SoC. Using the mfd/syscon driver is the best mechanism to
link the system manager to the other IPs.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: devicetree at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/socfpga.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index bee62a2..c31c8e9 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -520,8 +520,8 @@
 				reg = <0xffd05000 0x1000>;
 			};
 
-		sysmgr at ffd08000 {
-				compatible = "altr,sys-mgr";
+		system_mgr: sysmgr at ffd08000 {
+				compatible = "altr,sys-mgr", "syscon";
 				reg = <0xffd08000 0x4000>;
 			};
 	};
-- 
1.7.9.5
