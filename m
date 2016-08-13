From: isubramanian@apm.com (Iyappan Subramanian)
Date: Fri, 12 Aug 2016 22:05:48 -0700
Subject: [PATCH net-next v2 12/12] dtb: xgene: Fix backward compatibility
In-Reply-To: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
References: <1471064748-28033-1-git-send-email-isubramanian@apm.com>
Message-ID: <1471064748-28033-13-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the backward compatibility when used with older kernel.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index f1c2c71..d5c3435 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -923,7 +923,7 @@
 			/* mac address will be overwritten by the bootloader */
 			local-mac-address = [00 00 00 00 00 00];
 			phy-connection-type = "rgmii";
-			phy-handle = <&menet0phy>,<&menetphy>;
+			phy-handle = <&menetphy>,<&menet0phy>;
 			mdio {
 				compatible = "apm,xgene-mdio";
 				#address-cells = <1>;
-- 
1.9.1
