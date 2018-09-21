From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:52 +0530
Subject: [RFC PATCH 37/40] arm64: dts: k3-am6: Add Main System Control Module
 node
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-38-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Parrot <bparrot@ti.com>

Main System control module support is added to the device tree to allow
driver to access to their control module registers.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 2df4acb198bd..957c9125a453 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -6,6 +6,11 @@
  */
 
 &cbass_main {
+	scm_conf: scm_conf at 100000 {
+		compatible = "syscon";
+		reg = <0 0x00100000 0 0x1c000>;
+	};
+
 	gic500: interrupt-controller at 1800000 {
 		compatible = "arm,gic-v3";
 		#address-cells = <2>;
-- 
2.17.1
