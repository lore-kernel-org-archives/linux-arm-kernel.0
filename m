From: alex@digriz.org.uk (Alexander Clouter)
Date: Sat, 23 Mar 2013 22:29:57 +0000
Subject: [PATCHv2 4/4] arm: orion5x: correct IRQ used in dtsi for mv_cesa
In-Reply-To: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
References: <1364077797-21206-1-git-send-email-alex@digriz.org.uk>
Message-ID: <1364077797-21206-5-git-send-email-alex@digriz.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The crypto functionality hook in the orion5x dtsi uses an IRQ that clashes
with the Ethernet controller, so lets move it to use the IRQ that the non-DT
code utilises.

Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
---
 arch/arm/boot/dts/orion5x.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 3944b9b..f4be4c5 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -127,7 +127,7 @@
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
