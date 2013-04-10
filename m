From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 10 Apr 2013 10:10:13 +0900
Subject: [PATCH v2] ARM: shmobile: marzen-reference: use irqpin for lan
Message-ID: <1365556213-11827-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This corrects the configuration of the SMSC lan controller
to use the newly added irqpin as its IRQ source.

Previously the lan controller did not work. Now it does.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This depends on "[PATCH/RFC 0/2] ARM: shmobile: DT irqpin for r8a7779 and
marzen-reference".

v2
* Use interrupt 2 instead of 1.
  Apparently we should start counting from 1 rather than 0.
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 72be4c8..b37c24f 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -38,8 +38,8 @@
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18000000 0x100>;
 		phy-mode = "mii";
-		interrupt-parent = <&gic>;
-		interrupts = <0 28 0x4>;
+		interrupt-parent = <&irqpin0>;
+		interrupts = <2 0>;
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
-- 
1.7.10.4
