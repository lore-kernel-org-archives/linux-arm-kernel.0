From: hongtao.jia@nxp.com (Jia Hongtao)
Date: Tue, 25 Oct 2016 10:15:41 +0800
Subject: [PATCH V3 1/2] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
Message-ID: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hongtao Jia <hongtao.jia@nxp.com>

Update #thermal-sensor-cells from 0 to 1 according to the new binding. The
sensor specifier added is the monitoring site ID, and represents the "n" in
TRITSRn and TRATSRn.

Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
---
Changes for V3:
* Update the commit log to a better description.

Changes for V2:
* Rebase on latest linux-next tree (next-20161006).

 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 44e399b..145c7f4 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -526,7 +526,7 @@
 
 				       0x00030000 0x00000012
 				       0x00030001 0x0000001d>;
-		#thermal-sensor-cells = <0>;
+		#thermal-sensor-cells = <1>;
 	};
 
 	thermal-zones {
@@ -534,7 +534,7 @@
 			polling-delay-passive = <1000>;
 			polling-delay = <5000>;
 
-			thermal-sensors = <&tmu>;
+			thermal-sensors = <&tmu 2>;
 
 			trips {
 				cpu_alert: cpu-alert {
-- 
2.1.0.27.g96db324
