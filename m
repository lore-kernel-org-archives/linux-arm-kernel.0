From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  9 Sep 2016 10:01:02 -0400
Subject: [PATCH 1/8] ARM: dts: rockchip: Remove skeleton.dtsi inclusion in
 rk3036.dtsi
In-Reply-To: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
References: <1473429669-6185-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1473429669-6185-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The skeleton.dtsi file was removed in ARM64 for different reasons as
explained in commit ("3ebee5a2e141 arm64: dts: kill skeleton.dtsi").

These also applies to ARM and it will also allow to get rid of the
following DTC warnings in the future:

"Node /memory has a reg or ranges property, but no unit name"

The disassembled DTB are almost the same, besides empty chosen nodes
being removed. So the change should not have a functional impact.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/rk3036.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index a935523a1eb8..81691ae50199 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -44,9 +44,11 @@
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3036-cru.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
 	compatible = "rockchip,rk3036";
 
 	interrupt-parent = <&gic>;
-- 
2.7.4
