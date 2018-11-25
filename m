From: otavio@ossystems.com.br (Otavio Salvador)
Date: Sun, 25 Nov 2018 19:19:07 -0200
Subject: [PATCH 13/13] ARM: dts: rv1108: Pass the 'clock-latency' property
In-Reply-To: <20181125211907.9895-1-otavio@ossystems.com.br>
References: <20181125211907.9895-1-otavio@ossystems.com.br>
Message-ID: <20181125211907.9895-13-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Like it is done on cpu nodes of other Rockchip SoCs, pass the
'clock-latency' property to the CPU node, so that cpufreq driver
can take the latency into account when switching frequencies.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/rv1108.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index d96c58728b28..4e1ca13a1636 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -36,6 +36,7 @@
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <75>;
 			operating-points-v2 = <&cpu_opp_table>;
+			clock-latency = <40000>;
 		};
 	};
 
-- 
2.19.1
