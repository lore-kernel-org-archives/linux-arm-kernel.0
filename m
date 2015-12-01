From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue,  1 Dec 2015 20:03:21 +0200
Subject: [PATCH 19/19] ARM: dts: am57xx: cl-som-am57x: skip resetting ETH PHYs
In-Reply-To: <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448993001-19495-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1448993001-19495-20-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ETH PHYs setup on CL-SOM-AM57X is established in U-Boot along with
bringing them out of reset. This is done by toggling GPIOs belonging
to GPIO2/3 controllers on AM57xx.

Skip resetting ETH PHYs, by adding "ti,no-reset-on-init" to GPIO2/3
controllers DT nodes.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index b2c4451..c538826 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -605,3 +605,13 @@
 		1 2 0 0
 	>;
 };
+
+&gpio3 {
+	status = "okay";
+	ti,no-reset-on-init;
+};
+
+&gpio2 {
+	status = "okay";
+	ti,no-reset-on-init;
+};
-- 
1.9.1
