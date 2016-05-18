From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 18 May 2016 18:36:31 -0500
Subject: [PATCH 6/8] ARM: dts: dra7: Add dt node for the syscon control module
 wkup
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
Message-ID: <fb1b7f4b3f645decec4d3da1a71b204d4b8345fc.1463606963.git.d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create a system control module node for the control module portion that
resides under l4_wkup.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 3a8f3976f6f9..406f6ff21d7f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -233,6 +233,11 @@
 				prm_clockdomains: clockdomains {
 				};
 			};
+
+			scm_wkup: scm_conf at c000 {
+				compatible = "syscon";
+				reg = <0xc000 0x1000>;
+			};
 		};
 
 		axi at 0 {
-- 
2.7.3
