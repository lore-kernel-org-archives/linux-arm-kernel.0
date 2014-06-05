From: andrew.ruder@elecsyscorp.com (Andrew Ruder)
Date: Thu,  5 Jun 2014 14:27:06 -0500
Subject: [PATCH 4/6] arm: pxa2xx.dtsi: disable RTC by default
In-Reply-To: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
References: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
Message-ID: <5a807a8d36ef3313b0d48a2fe88720f1fe246d7f.1401995177.git.andrew.ruder@elecsyscorp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This sets the status="disabled" flag in pxa2xx.dtsi in the same style as
the other optional components.  This can be overridden on a case-by-case
basis by boards that use this functionality.

Signed-off-by: Andrew Ruder <andrew.ruder@elecsyscorp.com>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index c08f846..d233088 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -130,6 +130,7 @@
 			compatible = "marvell,pxa-rtc";
 			reg = <0x40900000 0x3c>;
 			interrupts = <30 31>;
+			status = "disabled";
 		};
 	};
 };
-- 
1.9.0.rc3.12.gbc97e2d
