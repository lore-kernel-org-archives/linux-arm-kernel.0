From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 20 Dec 2017 23:11:50 +0000
Subject: [PATCH 2/4] ARM: dts: vf610-zii-dev-rev-b: fix interrupt for GPIO
 expander
In-Reply-To: <20171220231108.GJ10595@n2100.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
Message-ID: <E1eRnWg-0006VE-GI@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt specification for the GPIO expander is wrong - the
expander is wired to PTB28, which is GPIO98.  GPIO98 is on gpio chip
3, not 2.

In addition, the device is missing a required property.  Interrupt
controllers must have the "interrupt-controller" property specified.
Add this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index acdf12ad0622..ede8649ba515 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -371,7 +371,8 @@
 		reg = <0x22>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		interrupt-parent = <&gpio2>;
+		interrupt-controller;
+		interrupt-parent = <&gpio3>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
-- 
2.7.4
