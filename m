From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Aug 2016 17:37:30 +0200
Subject: [PATCH 2/2] ARM: dts: STiH407-family: Add ports-implemented property
 in sata nodes
In-Reply-To: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
References: <1470843450-20068-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1470843450-20068-3-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Despite ST AHCI version = 1.3, reading HOST_PORTS_IMPL
returns 0. So force HOST_PORTS_IMPL to 1 by using
ports-implemented DT property.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index d294e82..36d40f0 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -608,6 +608,8 @@
 			clock-names = "ahci_clk";
 			clocks = <&clk_s_c0_flexgen CLK_ICN_REG>;
 
+			ports-implemented = <0x1>;
+
 			status = "disabled";
 		};
 
@@ -631,6 +633,8 @@
 			clock-names = "ahci_clk";
 			clocks = <&clk_s_c0_flexgen CLK_ICN_REG>;
 
+			ports-implemented = <0x1>;
+
 			status = "disabled";
 		};
 
-- 
1.9.1
