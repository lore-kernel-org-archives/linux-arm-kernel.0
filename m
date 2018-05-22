From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Tue, 22 May 2018 08:28:52 +0200
Subject: [PATCH v3 2/3] ARM: dts: imx6ull: add operating points
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
Message-ID: <20180522062853.24799-2-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6ULL has different operating ranges than i.MX6UL so add the
operating points for the i.MX6ULL. A 25mV offset is added to the minimum
allowed values like for the i.MX6UL.

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v3:
 - none

Changes for v2:
 - Fix soc-operating-points voltage for 792MHz and 900MHz

 arch/arm/boot/dts/imx6ull.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 571ddd71cdba..530d5526b890 100644
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
+		900000	1175000
+		792000	1175000
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
