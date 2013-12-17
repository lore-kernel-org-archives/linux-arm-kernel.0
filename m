From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:12:51 -0700
Subject: [PATCH V2 01/13] ARM: dts: imx6qdl-sabrelite: move pcie to
 imx6qdl-sabrelite.dtsi
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-2-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe is common to Quad, Dual, Dual Lite, and Solo variants
of the processor. So, move enabling from imx6q-sabrelite.dts
to imx6qdl-sabrelite.dtsi.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

---
v2: new patch which can be squashed with
6bbb49ddfa8466a91a2ce1411a2ac969d0d0a614
ARM: dts: imx: sabrelite: add Dual Lite/Solo support

if desired.
---
 arch/arm/boot/dts/imx6q-sabrelite.dts    | 4 ----
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 8128fb9..96e4688 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -19,10 +19,6 @@
 	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
 };
 
-&pcie {
-	status = "okay";
-};
-
 &sata {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index c4aa504..5394e02 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -187,6 +187,10 @@
 	};
 };
 
+&pcie {
+	status = "okay";
+};
+
 &ssi1 {
 	fsl,mode = "i2s-slave";
 	status = "okay";
-- 
1.8.1.2
