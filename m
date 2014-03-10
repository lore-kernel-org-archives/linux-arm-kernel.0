From: rogerq@ti.com (Roger Quadros)
Date: Mon, 10 Mar 2014 14:49:21 +0200
Subject: [PATCH v2 1/8] ARM: dts: dra7: Initialize USB_DPLL
In-Reply-To: <1394197751-28984-2-git-send-email-rogerq@ti.com>
References: <1394197751-28984-2-git-send-email-rogerq@ti.com>
Message-ID: <1394455761-19226-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB_DPLL must be initialized and locked at boot so that
USB modules can work.

Program USB_DLL_M2 output to half rate as well.

Patch depends on
https://www.mail-archive.com/linux-omap at vger.kernel.org/msg101300.html

CC: Mike Turquette <mturquette@linaro.org>
CC: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 597979b..f376923 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -815,3 +815,11 @@
 };
 
 /include/ "dra7xx-clocks.dtsi"
+
+&dpll_usb_ck {
+        default-rate = <960000000>;
+};
+
+&dpll_usb_m2_ck {
+	default-rate = <480000000>;
+};
-- 
1.8.3.2
