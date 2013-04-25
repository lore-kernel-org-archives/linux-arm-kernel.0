From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 25 Apr 2013 17:57:54 +0100
Subject: [PATCH v5 6/7] xenvm: add a simple PSCI node and a second cpu
In-Reply-To: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1304251750160.4180@kaball.uk.xensource.com>
Message-ID: <1366909075-28775-6-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
CC: rob.herring at calxeda.com
CC: will.deacon at arm.com
CC: arnd at arndb.de
---
 arch/arm/boot/dts/xenvm-4.2.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/xenvm-4.2.dts b/arch/arm/boot/dts/xenvm-4.2.dts
index ec3f952..3369151 100644
--- a/arch/arm/boot/dts/xenvm-4.2.dts
+++ b/arch/arm/boot/dts/xenvm-4.2.dts
@@ -29,6 +29,19 @@
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
+		cpu_off         = <1>;
+		cpu_on          = <2>;
 	};
 
 	memory at 80000000 {
-- 
1.7.2.5
