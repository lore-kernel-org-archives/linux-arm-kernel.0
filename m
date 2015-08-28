From: fan.chen@mediatek.com (fan.chen at mediatek.com)
Date: Fri, 28 Aug 2015 10:11:59 +0800
Subject: [PATCH] arm64: dts: mediatek: mt8173 PSCI-1.0 support
Message-ID: <1440727919-34719-1-git-send-email-fan.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fan Chen <fan.chen@mediatek.com>

This patch adds psci comatible properties to support all mandatory
functions of PSCI-1.0, PSCI-0.2 and PSCI-0.1, and system suspend
can be supported in PSCI-1.0.

Signed-off-by: Fan Chen <fan.chen@mediatek.com>
---
Because PSCI-1.0 patches hadn't landed on mainline, this patch is
based on three patch sets below:
[0] http://www.spinics.net/lists/arm-kernel/msg425793.html
    PSCI: system suspend support
[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
    psci/unification
[2] http://www.spinics.net/lists/devicetree/msg82017.html
    [PATCH 0/6] drivers: firmware: psci: add basic v1.0 support

Before they are merged in, this patch still works fine with psci-0.2
support in current mainline.
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index d18ee42..b9b4205 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -95,7 +95,7 @@
 	};
 
 	psci {
-		compatible = "arm,psci";
+		compatible = "arm,psci-1.0", "arm,psci-0.2", "arm,psci";
 		method = "smc";
 		cpu_suspend   = <0x84000001>;
 		cpu_off	      = <0x84000002>;
-- 
1.7.9.5
