From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 21 Mar 2013 19:16:20 +0000
Subject: [PATCH 4/4] xenvm: add a simple PSCI node and a second cpu
In-Reply-To: <alpine.DEB.2.02.1303211848150.5135@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1303211848150.5135@kaball.uk.xensource.com>
Message-ID: <1363893380-14309-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: rob.herring at calxeda.com
CC: will.deacon at arm.com
CC: marc.zyngier at arm.com
CC: arnd at arndb.de
---
 arch/arm/boot/dts/xenvm-4.2.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/xenvm-4.2.dts b/arch/arm/boot/dts/xenvm-4.2.dts
index 7a2cf30..66efd22 100644
--- a/arch/arm/boot/dts/xenvm-4.2.dts
+++ b/arch/arm/boot/dts/xenvm-4.2.dts
@@ -29,6 +29,18 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <1>;
+		};
+	};
+
+	psci {
+		compatible      = "arm,psci";
+		method          = "hvc";
+		cpu_on          = <2>;
 	};
 
 	memory at 80000000 {
-- 
1.7.2.5
