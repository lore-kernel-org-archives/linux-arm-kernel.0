From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Aug 2016 13:17:39 +0100
Subject: [PATCH 6/7] ARM: dts: STiH407-family: Add ports-implemented property
 in sata nodes
In-Reply-To: <20160815121740.29515-1-lee.jones@linaro.org>
References: <20160815121740.29515-1-lee.jones@linaro.org>
Message-ID: <20160815121740.29515-7-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
returns 0. So force HOST_PORTS_IMPL to 1 by using
ports-implemented DT property.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 59fea05..55ecfbe 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -607,6 +607,8 @@
 			clock-names = "ahci_clk";
 			clocks = <&clk_s_c0_flexgen CLK_ICN_REG>;
 
+			ports-implemented = <0x1>;
+
 			status = "disabled";
 		};
 
@@ -630,6 +632,8 @@
 			clock-names = "ahci_clk";
 			clocks = <&clk_s_c0_flexgen CLK_ICN_REG>;
 
+			ports-implemented = <0x1>;
+
 			status = "disabled";
 		};
 
-- 
2.9.0
