From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 19 Apr 2016 17:39:16 -0500
Subject: [PATCH 2/3] arm64: defconfig: enable 48-bit virtual addresses
Message-ID: <1461105556-23877-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some armv8 SoCs (e.g. ls2080a) have physical memory maps with discontiguous
DDR regions that require 48-bit VA to have the linear map cover the entire
range of DDR.

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 248c242..e8bc263 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -61,6 +61,7 @@ CONFIG_PCI_XGENE=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_HISI=y
 CONFIG_PCIE_QCOM=y
+CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
 CONFIG_PREEMPT=y
 CONFIG_KSM=y
-- 
1.9.0
