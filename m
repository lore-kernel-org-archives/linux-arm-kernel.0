From: nm@ti.com (Nishanth Menon)
Date: Tue, 21 Oct 2014 09:30:47 -0500
Subject: [PATCH 2/3] ARM: dts: dra72-evm: Add power button node
In-Reply-To: <1413901848-32268-1-git-send-email-nm@ti.com>
References: <1413901848-32268-1-git-send-email-nm@ti.com>
Message-ID: <1413901848-32268-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With Commit adff5962fdd2 ("Input: introduce palmas-pwrbutton"), we can
now support tps power button as a event source - This is SW7 (PB/WAKE)
on the J6-evm.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 671e473..1242a17 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -145,6 +145,14 @@
 				};
 			};
 		};
+
+		tps65917_power_button {
+			compatible = "ti,palmas-pwrbutton";
+			interrupt-parent = <&tps65917>;
+			interrupts = <1 IRQ_TYPE_NONE>;
+			wakeup-source;
+			ti,palmas-long-press-seconds = <6>;
+		};
 	};
 };
 
-- 
1.7.9.5
