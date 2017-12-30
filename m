From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 30 Dec 2017 16:23:30 +0100
Subject: [PATCH 3/3] ARM: dts: sun7i: lamobo-r1: Add backup battery charging
 property
In-Reply-To: <20171230152330.28946-1-contact@paulk.fr>
References: <20171230152330.28946-1-contact@paulk.fr>
Message-ID: <20171230152330.28946-4-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the axp20x backup property to the lamobo-r1 device-tree,
that allows charging the backup battery attached to its AXP209.

It is especially useful since the battery is used for the RTC module.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 442f3c755f36..e218fd8ea94f 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -207,6 +207,8 @@
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		backup = <3000 200>;
 	};
 };
 
-- 
2.15.1
