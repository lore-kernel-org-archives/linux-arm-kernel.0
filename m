From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Wed, 18 Apr 2018 16:52:30 +0200
Subject: [PATCH 2/2] ARM: dts: imx6ull: add operating points
In-Reply-To: <20180418145230.10249-1-sebastien.szymanski@armadeus.com>
References: <20180418145230.10249-1-sebastien.szymanski@armadeus.com>
Message-ID: <20180418145230.10249-2-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6ULL has different operating ranges than i.MX6UL so add the
operating points for the i.MX6ULL. A 25mV offset is added to the minimum
allowed values like for the i.MX6UL.

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 571ddd71cdba..7e6273be0291 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -46,6 +46,25 @@
 /* Delete UART8 in AIPS-1 (i.MX6UL specific) */
 /delete-node/ &uart8;
 
+&cpu0 {
+	operating-points = <
+		/* kHz	uV */
+		900000	1275000
+		792000	1225000
+		528000	1175000
+		396000	1025000
+		198000	950000
+	>;
+	fsl,soc-operating-points = <
+		/* KHz	uV */
+		900000	1400000
+		792000	1350000
+		528000	1175000
+		396000	1175000
+		198000	1175000
+	>;
+};
+
 / {
 	soc {
 		aips3: aips-bus at 2200000 {
-- 
2.16.1
