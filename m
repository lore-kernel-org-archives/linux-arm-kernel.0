From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  5 Jan 2016 09:27:42 +1100
Subject: [PATCH v2 07/13] ARM: shmobile: r8a7793: enable Audio DMAC peri peri
 via sound driver
In-Reply-To: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
References: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1451946468-20499-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Audio DMAC peri peri is no longer DMAEngine. it is supported by
sound driver. this patch enable it.

Base on work for the r8a7791 by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* New patch
---
 arch/arm/boot/dts/r8a7793.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index d9e284a6a34f..9eef99a132ec 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -1172,8 +1172,9 @@
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-			<0 0xec541000 0 0x280>;  /* SSI */
-		reg-names = "scu", "adg", "ssiu", "ssi";
+			<0 0xec541000 0 0x280>,  /* SSI */
+			<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+		reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 		clocks = <&mstp10_clks R8A7793_CLK_SSI_ALL>,
 			<&mstp10_clks R8A7793_CLK_SSI9>, <&mstp10_clks R8A7793_CLK_SSI8>,
-- 
2.1.4
