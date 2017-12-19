From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:21 -0600
Subject: [PATCH 3/8] ARM: dts: dra7: Enable 1.5 GHz operation for the CPU
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1513697066-27732-4-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After ti-opp-supply driver is in place to provide AVS Class0 and abb
regulator scaling support let's enable 1.5GHz for the cpu.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 33004e7f1ee9..eb68da74f777 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -116,6 +116,13 @@
 
 			opp-supported-hw = <0xFF 0x02>;
 		};
+
+		opp_high at 1500000000 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1210000 950000 1250000>,
+					<1210000 950000 1250000>;
+			opp-supported-hw = <0xFF 0x04>;
+		};
 	};
 
 	/*
-- 
2.15.1
