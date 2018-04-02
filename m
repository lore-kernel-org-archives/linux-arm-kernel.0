From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon,  2 Apr 2018 09:04:28 +0800
Subject: [PATCH v5 10/10] arm64: defconfig: update config for Rockchip PCIe
In-Reply-To: <1522630865-151344-1-git-send-email-shawn.lin@rock-chips.com>
References: <1522630865-151344-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1522631068-151816-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now Rockchip PCIe drivers could support both of host mode
and endponint mode, so we rename the config name. This patch
updates defconfig to refect the fact that we want to build
Rockchip PCIe controller driver into a module as before.

Cc: linux-arm-kernel at lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..17ea72b 100644
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
