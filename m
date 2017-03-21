From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 21 Mar 2017 16:36:01 +0100
Subject: [PATCH v3 01/11] ARM: sun8i: a33: add operating-points-v2 property to
 all nodes
In-Reply-To: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
Message-ID: <20170321153611.16228-2-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OPP are declared as shared but no operating points are declared for
cpu1, 2 and 3. Thus, the following error happens during the boot:

cpu cpu1: dev_pm_opp_of_get_sharing_cpus: Couldn't find tcpu_dev node.

This patch applies the operating points to each cpu of the A33.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 arch/arm/boot/dts/sun8i-a33.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index e1e74b8..39b2d78 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -75,16 +75,22 @@
 			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
+		cpu at 1 {
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+
 		cpu at 2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
-- 
2.9.3
