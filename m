From: j-keerthy@ti.com (Keerthy)
Date: Mon, 8 Feb 2016 14:46:30 +0530
Subject: [PATCH 3/3] arm: dts: DRA7: Add missing IVA and DSPEVE thermal domain
 data
In-Reply-To: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
References: <1454922990-7501-1-git-send-email-j-keerthy@ti.com>
Message-ID: <1454922990-7501-4-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP5 has 3 thermal zones cpu, core and multimedia.
On the other hand DRA7 has 5 thermal zones cpu, gpu, core, dspeve
and iva. Currently cpu, core and multimedia are being added via device tree
and the other 2 are getting added via kernel. Add the missing thermal
domains in device tree so we can create the zones with the appropriate
trip numbers, type and temperatures.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c4d9175..9f65d0d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1603,6 +1603,8 @@
 		#include "omap4-cpu-thermal.dtsi"
 		#include "omap5-gpu-thermal.dtsi"
 		#include "omap5-core-thermal.dtsi"
+		#include "dra7-dspeve-thermal.dtsi"
+		#include "dra7-iva-thermal.dtsi"
 	};
 
 };
-- 
1.9.1
