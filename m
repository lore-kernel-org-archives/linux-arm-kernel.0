From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Aug 2012 11:46:41 +0100
Subject: [PATCH 5/6] ARM: ux500: Match-up compatible stings with associated
 MFD cell
In-Reply-To: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1344250002-6011-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, we've either taken the IRQs listed in the MFD cell defined
in the AB8500 driver, or the ones in Device Tree when we probed each
AB8500 MFD device independently. However, now we make a logical choice
based on whether we're running Device Tree or not. For this to happen
we need the compatible stings in the AB8500 MFD cell and the DT to
match-up. We do that here.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 83229f7..0282353 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -355,7 +355,7 @@
 				};
 
 				ab8500-ponkey {
-					compatible = "stericsson,ab8500-ponkey";
+					compatible = "stericsson,ab8500-poweron-key";
 					interrupts = <6 0x4
 						      7 0x4>;
 					interrupt-names = "ONKEY_DBF", "ONKEY_DBR";
-- 
1.7.9.5
