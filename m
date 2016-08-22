From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 22 Aug 2016 18:09:36 +0200
Subject: [PATCH] ARM: dts: kirkwood: Fix PCIe label on OpenRD
Message-ID: <20160822160936.24873-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While converting PCIe node on kirkwood by using label, the following
commit eb13cf8345e9 ("ARM: dts: kirkwood: Fixup pcie DT warnings")
introduced a regression on the OpenRD boards: the PCIe didn't work
anymore. As reported by Aaro Koskinen, the display/framebuffer was
lost. This commit adds the forgotten label.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Fixes: eb13cf8345e9 ("ARM: dts: kirkwood: Fixup pcie DT warnings")
Cc: stable at vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-openrd.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
index e4ecab112601..7175511a92da 100644
--- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
+++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
@@ -116,6 +116,10 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+};
+
 &pcie0 {
 	status = "okay";
 };
-- 
2.9.3
