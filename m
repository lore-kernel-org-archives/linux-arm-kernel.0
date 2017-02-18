From: ben@decadent.org.uk (Ben Hutchings)
Date: Sat, 18 Feb 2017 00:32:51 +0000
Subject: [PATCH] ARM: dts: kirkwood: Fix SATA pinmux-ing for TS419
Message-ID: <20170218003251.GC4152@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old board code for the TS419 assigns MPP pins 15 and 16 as SATA
activity signals (and none as SATA presence signals).  Currently the
device tree assigns the SoC's default pinmux groups for SATA, which
conflict with the second Ethernet port.

Reported-by: gmbh at gazeta.pl
Tested-by: gmbh at gazeta.pl
References: https://bugs.debian.org/855017
Cc: stable at vger.kernel.org # 3.15+
Fixes: 934b524b3f49 ("ARM: Kirkwood: Add DT description of QNAP 419")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/boot/dts/kirkwood-ts419.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/kirkwood-ts419.dtsi b/arch/arm/boot/dts/kirkwood-ts419.dtsi
index 02bd53762705..532506cb0f4a 100644
--- a/arch/arm/boot/dts/kirkwood-ts419.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts419.dtsi
@@ -73,3 +73,11 @@
 		phy-handle = <&ethphy1>;
 	};
 };
+
+&pmx_sata0 {
+	marvell,pins = "mpp15";
+};
+
+&pmx_sata1 {
+	marvell,pins = "mpp16";
+};
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170218/7d56af58/attachment.sig>
