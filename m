From: venture@google.com (Patrick Venture)
Date: Wed, 22 Aug 2018 09:30:10 -0700
Subject: [PATCH 1/2] ARM: dts: aspeed: quanta-q71l: add aliases for i2c
Message-ID: <20180822163010.70207-1-venture@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide aliases to each i2c bus per labels added for
each PCIe slot, etc, that are downstream beyond a mux.

Signed-off-by: Patrick Venture <venture@google.com>
---
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
index 76aa6ea1f988..586050e1c0e6 100644
--- a/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts
@@ -7,6 +7,25 @@
 	model = "Quanta Q71L BMC";
 	compatible = "quanta,q71l-bmc", "aspeed,ast2400";
 
+	aliases {
+		i2c14 = &i2c_pcie2;
+		i2c15 = &i2c_pcie3;
+		i2c16 = &i2c_pcie6;
+		i2c17 = &i2c_pcie7;
+		i2c18 = &i2c_pcie1;
+		i2c19 = &i2c_pcie4;
+		i2c20 = &i2c_pcie5;
+		i2c21 = &i2c_pcie8;
+		i2c22 = &i2c_pcie9;
+		i2c23 = &i2c_pcie10;
+		i2c24 = &i2c_ssd1;
+		i2c25 = &i2c_ssd2;
+		i2c26 = &i2c_psu4;
+		i2c27 = &i2c_psu1;
+		i2c28 = &i2c_psu3;
+		i2c29 = &i2c_psu2;
+	};
+
 	chosen {
 		stdout-path = &uart5;
 		bootargs = "console=ttyS4,115200 earlyprintk";
-- 
2.18.0.1017.ga543ac7ca45-goog
