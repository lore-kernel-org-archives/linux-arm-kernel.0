From: mohit.kumar@st.com (Mohit Kumar)
Date: Thu, 23 Jan 2014 16:02:41 +0530
Subject: [PATCH V2 1/8] SPEAr13xx: Set dt field entry <stmmac,
 phy-addr> for phy probe
In-Reply-To: <cover.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
Message-ID: <12754927160d11063aad96c011c4807cb0aa1775.1390471111.git.mohit.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT field name for the phy address changed since kernel 3.10. Set the
snps,phy-addr to 0xffffffff so that the driver probes for the phy.

Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: spear-devel at list.st.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/spear13xx.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index 4382547..3518803 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -155,6 +155,7 @@
 
 		gmac0: eth at e2000000 {
 			compatible = "st,spear600-gmac";
+			snps,phy-addr = <0xffffffff>;
 			reg = <0xe2000000 0x8000>;
 			interrupts = <0 33 0x4
 				      0 34 0x4>;
-- 
1.7.0.1
