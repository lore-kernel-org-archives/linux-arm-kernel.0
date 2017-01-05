From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:31 -0600
Subject: [PATCH 09/12] ARM: dts: socfpga: fpga manager data is 32 bits
In-Reply-To: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
References: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1483575694-29599-10-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adjust regs property for the FPGA manager data register to
properly reflect that it is a single 32 bit register.

Signed-off-by: Dalon Westergreen <dwesterg@altera.com>
Signed-off-by: Alan Tull <atull@opensource.altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index da68965..de29172 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -516,7 +516,7 @@
 		fpgamgr0: fpgamgr at ff706000 {
 			compatible = "altr,socfpga-fpga-mgr";
 			reg = <0xff706000 0x1000
-			       0xffb90000 0x1000>;
+			       0xffb90000 0x4>;
 			interrupts = <0 175 4>;
 		};
 
-- 
2.7.4
