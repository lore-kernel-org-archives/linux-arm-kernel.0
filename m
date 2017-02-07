From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  8 Feb 2017 02:30:37 +0800
Subject: [PATCH v4 4/9] ARM: dts: sun8i: convert H3 dtsi to use new
 sunxi-h3-h5 binding header
In-Reply-To: <20170207183042.62699-1-icenowy@aosc.xyz>
References: <20170207183042.62699-1-icenowy@aosc.xyz>
Message-ID: <20170207183042.62699-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the process that adds H5 support to the original H3 CCU
driver, the device tree binding header changed its name.

Convert the H3 DTSI to use the new binding header.

The only names for H3 changed are {CLK,RST}_BUS_SCR to
{CLK,RST}_BUS_SCR0, not currently used now; so only the header
file's name is changed.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch in v4.

 arch/arm/boot/dts/sun8i-h3.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 48f9a0419b82..735e9cef334f 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -42,10 +42,10 @@
 
 #include "skeleton.dtsi"
 
-#include <dt-bindings/clock/sun8i-h3-ccu.h>
+#include <dt-bindings/clock/sunxi-h3-h5-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
-#include <dt-bindings/reset/sun8i-h3-ccu.h>
+#include <dt-bindings/reset/sunxi-h3-h5-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
-- 
2.11.0
