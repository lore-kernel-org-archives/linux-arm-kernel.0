From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 25 Jan 2018 18:03:10 +0000
Subject: [RFC 36/37] ARM: dts: iwg20m: Add watchdog support to SoM dtsi
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1516903391-30467-37-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the watchdog from within the iwg20m SoM dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index 1d3e950..d364685 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -91,6 +91,11 @@
 	};
 };
 
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
