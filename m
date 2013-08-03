From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat,  3 Aug 2013 20:00:54 +0200
Subject: [PATCH] ARM: DTS: AM33XX: Add PMU support
Message-ID: <1375552854-8468-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM Performance Monitor Units are available on the am33xx, add the support in
the dtsi.

Tested with perf and oprofile on a regular beaglebone.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..cfeac96 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -53,6 +53,11 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a8-pmu";
+		interrupts = <3>;
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
-- 
1.8.1.2
