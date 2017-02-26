From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 26 Feb 2017 09:19:53 +0800
Subject: [PATCH v5 4/7] ARM: dts: sun8i: convert H3 dtsi to use new
 sunxi-h3-h5 binding header
In-Reply-To: <20170226011956.53581-1-icenowy@aosc.xyz>
References: <20170226011956.53581-1-icenowy@aosc.xyz>
Message-ID: <20170226011956.53581-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the process that adds H5 support to the original H3 CCU
driver, the device tree binding header changed its name.

Convert the H3 DTSI to use the new binding header.

The only names for H3 changed are {CLK,RST}_BUS_SCR to
{CLK,RST}_BUS_SCR0, not currently used now; so only the header
file's name is changed.

The compatible symlinks are also removed in this commit.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v5:
- Delete transitional headers here.

 arch/arm/boot/dts/sun8i-h3.dtsi          | 4 ++--
 include/dt-bindings/clock/sun8i-h3-ccu.h | 1 -
 include/dt-bindings/reset/sun8i-h3-ccu.h | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)
 delete mode 120000 include/dt-bindings/clock/sun8i-h3-ccu.h
 delete mode 120000 include/dt-bindings/reset/sun8i-h3-ccu.h

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 27780b97c863..8a4d7894a11f 100644
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
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
deleted file mode 120000
index ef38232141e4..000000000000
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ /dev/null
@@ -1 +0,0 @@
-sunxi-h3-h5-ccu.h
\ No newline at end of file
diff --git a/include/dt-bindings/reset/sun8i-h3-ccu.h b/include/dt-bindings/reset/sun8i-h3-ccu.h
deleted file mode 120000
index ef38232141e4..000000000000
--- a/include/dt-bindings/reset/sun8i-h3-ccu.h
+++ /dev/null
@@ -1 +0,0 @@
-sunxi-h3-h5-ccu.h
\ No newline at end of file
-- 
2.11.1
