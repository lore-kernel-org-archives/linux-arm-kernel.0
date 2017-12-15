From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 15 Dec 2017 11:16:43 -0600
Subject: [PATCH 2/2] ARM: dts: am43x-epos-evm: Hook dcdc2 as the cpu0-supply
In-Reply-To: <20171215171643.8345-1-d-gerlach@ti.com>
References: <20171215171643.8345-1-d-gerlach@ti.com>
Message-ID: <20171215171643.8345-3-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook dcdc2 as the cpu0-supply.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index a04d79ec212a..1c79c1f8ac07 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -989,3 +989,7 @@
 	assigned-clocks = <&mux_synctimer32k_ck>;
 	assigned-clock-parents = <&clkdiv32k_ick>;
 };
+
+&cpu {
+	cpu0-supply = <&dcdc2>;
+};
-- 
2.15.1
