From: alex@digriz.org.uk (Alexander Clouter)
Date: Tue, 26 Mar 2013 21:44:49 +0000
Subject: [PATCHv3 4/4] arm: orion5x: correct IRQ used in dtsi for mv_cesa
In-Reply-To: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
References: <1364334289-19669-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364334289-19669-5-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The crypto functionality in the orion5x dtsi uses the Ethernet IRQ and
so things do not work and there is much grumbling at boot time.
The IRQ for the crypto should be 28, and not 22, and that is what this
patch corrects.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/boot/dts/orion5x.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index c37290b..892c64e 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -129,7 +129,7 @@
 			reg = <0x90000 0x10000>,
 			      <0xf2200000 0x800>;
 			reg-names = "regs", "sram";
-			interrupts = <22>;
+			interrupts = <28>;
 			status = "okay";
 		};
 	};
-- 
1.7.10.4
