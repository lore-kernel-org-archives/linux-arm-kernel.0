From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 21 May 2013 19:38:02 +0530
Subject: [PATCH 3/3] ARM: davinci: da850: adopt to pinctrl-single driver to
 configure multiple pins
In-Reply-To: <1369145282-14419-1-git-send-email-prakash.pm@ti.com>
References: <1369145282-14419-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1369145282-14419-5-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

function-mask property is a mask for a pin at each pin configure offset
in a pincontrol register.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
 arch/arm/boot/dts/da850.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 4d43046..9bec36c 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -37,7 +37,7 @@
 			#size-cells = <0>;
 			pinctrl-single,bit-per-mux;
 			pinctrl-single,register-width = <32>;
-			pinctrl-single,function-mask = <0xffffffff>;
+			pinctrl-single,function-mask = <0xf>;
 			status = "disabled";
 
 			nand_cs3_pins: pinmux_nand_pins {
-- 
1.7.4.1
