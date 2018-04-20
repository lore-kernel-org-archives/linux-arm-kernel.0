From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 20 Apr 2018 16:58:05 +0800
Subject: [PATCH] arm64: defconfig: Enable CONFIG_PINCTRL_MT7622 by default
Message-ID: <aac9629afc510681a5dad1a24eb78f5f84f12c23.1524214111.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Recently kernelCI reported the board mt7622-rfb1 has a fail test with
kernel: ERROR: did not start booting whose details could be seen at [1].

The cause is that UART0 can't output anything when it's missing a proper
pin setup with current DTS, so the essential driver is always getting
enabled to fix up the issue.

[1] https://kernelci.org/boot/id/5ad7d62759b51461bfb1f829/

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: stable at vger.kernel.org
Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..fe005df 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -320,6 +320,7 @@ CONFIG_PINCTRL_MAX77620=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
 CONFIG_PINCTRL_MSM8996=y
+CONFIG_PINCTRL_MT7622=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_DWAPB=y
-- 
2.7.4
