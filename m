From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed,  9 May 2018 09:13:37 +0800
Subject: [PATCH v7 7/7] arm64: defconfig: update config for Rockchip PCIe
In-Reply-To: <1525828278-69800-1-git-send-email-shawn.lin@rock-chips.com>
References: <1525828278-69800-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1525828417-70201-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now Rockchip PCIe drivers could support both of RC mode and EP
mode, so we need rename the config name. This patch updates
defconfig to reflect the fact that we want to build Rockchip PCIe
controller as RC mode, into a module as before.

Cc: linux-arm-kernel at lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1d3b406..8fd8bae 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -78,7 +78,8 @@ CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR=y
-CONFIG_PCIE_ROCKCHIP=m
+CONFIG_PCIE_ROCKCHIP=y
+CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_HOST_THUNDER_PEM=y
-- 
1.9.1
