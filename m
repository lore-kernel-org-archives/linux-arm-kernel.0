From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 15:17:21 +0200
Subject: [PATCH v4 07/23] ARM: dts: r8a7792: Add device node for RST module
In-Reply-To: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477055857-17936-8-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the RST module, which provides a.o. reset control
and mode pin monitoring.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 arch/arm/boot/dts/r8a7792.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7792.dtsi b/arch/arm/boot/dts/r8a7792.dtsi
index 713141d38b3ea960..6e1f61f65d292b0b 100644
--- a/arch/arm/boot/dts/r8a7792.dtsi
+++ b/arch/arm/boot/dts/r8a7792.dtsi
@@ -118,6 +118,11 @@
 				      IRQ_TYPE_LEVEL_LOW)>;
 		};
 
+		rst: reset-controller at e6160000 {
+			compatible = "renesas,r8a7792-rst";
+			reg = <0 0xe6160000 0 0x0100>;
+		};
+
 		sysc: system-controller at e6180000 {
 			compatible = "renesas,r8a7792-sysc";
 			reg = <0 0xe6180000 0 0x0200>;
-- 
1.9.1
