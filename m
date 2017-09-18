From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 09:58:14 +0200
Subject: [PATCH 9/9] arm64: dts: marvell: 8040-db: enable the SFP ports
In-Reply-To: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
Message-ID: <20170918075814.27405-10-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the SFP ports on the Armada 8040 DB as these ports
are now supported by the PPv2 driver (since the PHY is now optional).

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-db.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 0d7b2ae46610..26a018329a74 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -200,6 +200,11 @@
 	status = "okay";
 };
 
+&cpm_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+};
+
 &cpm_eth2 {
 	status = "okay";
 	phy = <&phy1>;
@@ -244,6 +249,11 @@
 	status = "okay";
 };
 
+&cps_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+};
+
 &cps_eth1 {
 	status = "okay";
 	phy = <&phy0>;
-- 
2.13.5
