From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:50 -0700
Subject: [PATCH v3 9/9] ARM: dts: fix Cygnus nand device node
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442873570-20947-10-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The third compatible string "brcm,brcmnand" in bcm-cygnus.dtsi nand node
is incorrect, redundant and should be removed. "brcm,brcmnand" is meant to
be used by STB based Broadcom SoCs. All iProc based SoCs should use
"brcm,nand-iproc".

Signed-off-by: Ray Jui <rjui@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 24e058c..b5f9f34 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -234,8 +234,7 @@
 		};
 
 		nand: nand at 18046000 {
-			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1",
-				     "brcm,brcmnand";
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1";
 			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
 			      <0x18046f00 0x20>;
 			reg-names = "nand", "iproc-idm", "iproc-ext";
-- 
1.9.1
