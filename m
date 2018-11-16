From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 16 Nov 2018 15:31:11 +0530
Subject: [PATCH 2/6] ARM: dts: ls1021a: Add all CPUs in cooling maps
In-Reply-To: <cover.1542362000.git.viresh.kumar@linaro.org>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
Message-ID: <4e3e13854a25a2c59a8202872191be329ae4d5f1.1542362000.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdd6e66a79ad..2a411eb1ebb0 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -324,6 +324,8 @@
 						trip = <&cpu_alert>;
 						cooling-device =
 							<&cpu0 THERMAL_NO_LIMIT
+							THERMAL_NO_LIMIT>,
+							<&cpu1 THERMAL_NO_LIMIT
 							THERMAL_NO_LIMIT>;
 					};
 				};
-- 
2.19.1.568.g152ad8e3369a
