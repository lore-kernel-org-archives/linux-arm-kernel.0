From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 09:58:10 +0200
Subject: [PATCH 5/9] arm64: dts: marvell: mcbin: add comphy references to
 Ethernet ports
In-Reply-To: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
Message-ID: <20170918075814.27405-6-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds comphy phandles to the Ethernet ports in the mcbin
device tree. The comphy is used to configure the serdes PHYs used by
these ports.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
index acf5c7d16d79..9a3b4a1fd445 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
@@ -223,6 +223,7 @@
 &cpm_eth0 {
 	status = "okay";
 	phy = <&phy0>;
+	phys = <&cpm_comphy4 0>;
 	phy-mode = "10gbase-kr";
 };
 
@@ -258,6 +259,7 @@
 &cps_eth0 {
 	status = "okay";
 	phy = <&phy8>;
+	phys = <&cps_comphy4 0>;
 	phy-mode = "10gbase-kr";
 };
 
@@ -266,6 +268,7 @@
 	status = "okay";
 	phy = <&ge_phy>;
 	phy-mode = "sgmii";
+	phys = <&cps_comphy0 1>;
 };
 
 &cps_pinctrl {
-- 
2.13.5
