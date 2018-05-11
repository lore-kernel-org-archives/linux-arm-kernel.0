From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 11 May 2018 23:23:26 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77980: disable EtherAVB
In-Reply-To: <5844eef7-0f5e-6366-4d3d-a3a658e7f988@cogentembedded.com>
References: <5844eef7-0f5e-6366-4d3d-a3a658e7f988@cogentembedded.com>
Message-ID: <8924a536-9f97-da8a-fd6f-bb53f433d55d@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding the R8A77980 EtherAVB device I failed to notice that it does
not have the usual "status" property disabling the described devices in
anticipation that the board device trees enable the devices according to
their needs. This causes the EtherAVB driver to successfully probe despite
e.g. the needed pins not having been configured -- luckily, "eth<n>" device
can't be opened anyway...

Fixes: bf6f90832f81 ("arm64: dts: renesas: r8a77980: add EtherAVB support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |    1 +
 1 file changed, 1 insertion(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -244,6 +244,7 @@
 			phy-mode = "rgmii";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		scif0: serial at e6e60000 {
