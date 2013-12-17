From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Mon, 16 Dec 2013 18:13:00 -0700
Subject: [PATCH V2 10/13] ARM: dts: imx6qdl-sabrelite: add skews for Micrel phy
In-Reply-To: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <1387242783-1462-11-git-send-email-troy.kisky@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the data delays to min, and clock delays to max
because the traces are equal length on pcb.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
Reviewed-by: Marek Vasut <marex@denx.de>

---
v2: no change
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 723259f..532a7e0 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -149,6 +149,18 @@
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
 	phy-reset-gpios = <&gpio3 23 0>;
+	txen-skew-ps = <0>;
+	txc-skew-ps = <3000>;
+	rxdv-skew-ps = <0>;
+	rxc-skew-ps = <3000>;
+	rxd0-skew-ps = <0>;
+	rxd1-skew-ps = <0>;
+	rxd2-skew-ps = <0>;
+	rxd3-skew-ps = <0>;
+	txd0-skew-ps = <0>;
+	txd1-skew-ps = <0>;
+	txd2-skew-ps = <0>;
+	txd3-skew-ps = <0>;
 	status = "okay";
 };
 
-- 
1.8.1.2
