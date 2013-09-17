From: nm@ti.com (Nishanth Menon)
Date: Tue, 17 Sep 2013 11:47:13 -0500
Subject: [PATCH] ARM: dts: DRA7: provide arch-timer frequenecy parameter
Message-ID: <1379436433-24914-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNTFREQ isn't pre-programmed on DRA7 just like O5, so provide the
same. Without a valid value arch_timer_init results in div0 crash.
Providing the same is a safer alternative.

Cc: R Sricharan <r.sricharan@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on Benoit's for_3.13/dts branch. 
http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
Without this patch, div0 error occurs(seen on 3.12-rc1 tag): http://pastebin.com/B2sDauS9

 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c01ef76..b478beb 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -50,6 +50,7 @@
 			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		clock-frequency = <6144000>;
 	};
 
 	gic: interrupt-controller at 48211000 {
-- 
1.7.9.5
