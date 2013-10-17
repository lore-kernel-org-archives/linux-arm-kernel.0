From: cinifr@gmail.com (Fan Rong)
Date: Fri, 18 Oct 2013 00:37:06 +0800
Subject: [Add SMP support for Allwinner A20: PATCH V5 2/3] Add cpuconfig nodes
 in dts for smp configure.
In-Reply-To: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
References: <1382027827-10080-1-git-send-email-cinifr@gmail.com>
Message-ID: <1382027827-10080-3-git-send-email-cinifr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cpu Configure regiser can be used for reset and boot smp cpus in allwiner's A20.

Signed-off-by: Fan Rong <cinifr@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e46cfed..6543b3f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -270,6 +270,11 @@
 			reg = <0x01c23800 0x200>;
 		};
 
+		cpuconfig: cpuconfig at 01c25c00 {
+			compatible = "allwinner,sun7i-a20-cpuconfig";
+			reg = <0x01c25c00 0x400>;
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
1.8.1.2
