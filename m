From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 12:12:25 -0400
Subject: [PATCH 6/8] ARM: dts: keystone: Add clock phandle to UART nodes
In-Reply-To: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375719147-7578-7-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now since the clock tree is added, update UART dt nodes with clock data.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/keystone.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
index 57a7cd9..5a2d632 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dts
@@ -102,6 +102,7 @@
 			reg-io-width = <4>;
 			reg = <0x02530c00 0x100>;
 			clock-frequency = <133120000>;
+			clocks	= <&clkuart0>;
 			interrupts = <0 277 0xf01>;
 		};
 
@@ -112,6 +113,7 @@
 			reg-io-width = <4>;
 			reg = <0x02531000 0x100>;
 			clock-frequency = <133120000>;
+			clocks	= <&clkuart1>;
 			interrupts = <0 280 0xf01>;
 		};
 
-- 
1.7.9.5
