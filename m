From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu,  8 Sep 2016 11:26:00 -0400
Subject: [PATCH 1/2] ARM: dts: s5p: Remove skeleton.dtsi inclusion for S5PV210
In-Reply-To: <1473348361-15784-1-git-send-email-javier@osg.samsung.com>
References: <1473348361-15784-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1473348361-15784-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The skeleton.dtsi file was removed in ARM64 for different reasons as
explained in commit ("3ebee5a2e141 arm64: dts: kill skeleton.dtsi").

These also applies to ARM and it will also allow to get rid of the
following DTC warnings in the future:

"Node /memory has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/s5pv210.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index ffc36bd24d2f..a853918be43f 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -19,11 +19,13 @@
  * published by the Free Software Foundation.
 */
 
-#include "skeleton.dtsi"
 #include <dt-bindings/clock/s5pv210.h>
 #include <dt-bindings/clock/s5pv210-audss.h>
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	aliases {
 		csis0 = &csis0;
 		fimc0 = &fimc0;
-- 
2.7.4
