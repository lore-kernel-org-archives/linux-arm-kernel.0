From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 20 Sep 2014 20:06:31 +0200
Subject: [PATCH 5/5] ARM: mvebu: armada-xp: Configure ix4-300d PCIe0 to x4
In-Reply-To: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411236391-422-6-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe controller on Port 0 of Lenovo ix4-300d is configured as
quad-lane x4. Correct the marvell,pcie-lane property accordingly.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Pawel Moll <pawel.moll@arm.com> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
Cc: Kumar Gala <galak@codeaurora.org> 
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> 
Cc: devicetree at vger.kernel.org 
Cc: linux-kernel at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 86be971f8fec..11f483c960b0 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -249,6 +249,7 @@
 
 /* Quad port SATA: Marvell 88SX7042 */
 &pcie00 {
+	marvell,pcie-lane = <0 1 2 3>;
 	status = "okay";
 };
 
-- 
2.0.0
