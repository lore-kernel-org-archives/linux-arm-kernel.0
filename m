From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 11 May 2018 23:21:57 +0300
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77970: disable EtherAVB
In-Reply-To: <5844eef7-0f5e-6366-4d3d-a3a658e7f988@cogentembedded.com>
References: <5844eef7-0f5e-6366-4d3d-a3a658e7f988@cogentembedded.com>
Message-ID: <653a7410-20ba-2cc9-b223-09c00d5be280@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When adding the R8A77970 EtherAVB device I failed to notice that it does
not have the usual "status" property disabling the described devices in
anticipation that the board device trees enable the devices according to
their needs. This causes the EtherAVB driver to successfully probe despite
e.g. the needed pins not having been configured -- luckily, "eth<n>" device
can't be opened anyway...

Fixes: bea2ab136eaa ("arm64: dts: renesas: r8a77970: add EtherAVB support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi |    1 +
 1 file changed, 1 insertion(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -473,6 +473,7 @@
 			iommus = <&ipmmu_rt 3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 
 		scif0: serial at e6e60000 {
