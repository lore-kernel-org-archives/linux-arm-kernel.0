From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sat, 29 Jul 2017 20:35:25 +0000
Subject: [PATCH] arm64: dts: cavium: fix memory node dtc warnings
In-Reply-To: <CAL_JsqLgPRQqWu=Fh-6EroHs64_M9Q8jWa20Hv=dGro62oR=XA@mail.gmail.com>
References: <CAL_JsqLgPRQqWu=Fh-6EroHs64_M9Q8jWa20Hv=dGro62oR=XA@mail.gmail.com>
Message-ID: <1501360525-78484-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Newer dtc versions generate a warning for thunder2-99xx.dts of the form:
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Fixup the memory node name to avoid this.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/boot/dts/cavium/thunder2-99xx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/cavium/thunder2-99xx.dts b/arch/arm64/boot/dts/cavium/thunder2-99xx.dts
index 6c6fb86..fc7c9dd 100644
--- a/arch/arm64/boot/dts/cavium/thunder2-99xx.dts
+++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dts
@@ -18,7 +18,7 @@
 	model = "Cavium ThunderX2 CN99XX";
 	compatible = "cavium,thunderx2-cn9900", "brcm,vulcan-soc";
 
-	memory {
+	memory at 80000000 {
 		device_type = "memory";
 		reg = <0x00000000 0x80000000 0x0 0x80000000>,  /* 2G @ 2G  */
 		      <0x00000008 0x80000000 0x0 0x80000000>;  /* 2G @ 34G */
-- 
2.7.4
