From: mohit.kumar@st.com (Mohit Kumar)
Date: Wed, 11 Dec 2013 15:08:26 +0530
Subject: [PATCH 01/12] SPEAr13xx: Correct dt field name for stmmac phy-addr
In-Reply-To: <cover.1386752447.git.mohit.kumar@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
Message-ID: <1078549fa412fb34ab2c95a6232096570abee12d.1386752447.git.mohit.kumar@st.com>
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
