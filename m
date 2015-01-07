From: vigneshr@ti.com (Vignesh R)
Date: Wed, 7 Jan 2015 11:19:38 +0530
Subject: [PATCH v6 5/6] ARM: dts: AM335x: Make charge delay a DT parameter for
 TSC
In-Reply-To: <1420609779-11156-1-git-send-email-vigneshr@ti.com>
References: <1420609779-11156-1-git-send-email-vigneshr@ti.com>
Message-ID: <1420609779-11156-6-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The charge delay value is by default 0x400. But it can be set to lower
values on some boards, as long as false pen-ups are avoided. Lowering the
value increases the sampling rate (though current sampling rate is
sufficient for TSC operation). In some boards, the value has to be
increased to avoid false pen-up events. Hence, charge delay has been
made a DT parameter.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 54f118c08db8..66342515df20 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -648,6 +648,7 @@
 		ti,x-plate-resistance = <200>;
 		ti,coordinate-readouts = <5>;
 		ti,wire-config = <0x00 0x11 0x22 0x33>;
+		ti,charge-delay = <0x400>;
 	};
 
 	adc {
-- 
1.9.1
