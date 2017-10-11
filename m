From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 11 Oct 2017 16:15:41 +0100
Subject: [PATCH] arm64: Add ThunderX drivers to defconfig
Message-ID: <8d21bb00c687f0f4522f886db5c2836d0b4ca031.1507734829.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ThunderX needs its PCI host drivers to do anything useful, and
it's probably helpful to have networking by default too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34480e9af2e7..1c8e0d77deee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -76,6 +76,8 @@ CONFIG_PCIE_RCAR=y
 CONFIG_PCIE_ROCKCHIP=m
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
+CONFIG_PCI_HOST_THUNDER_PEM=y
+CONFIG_PCI_HOST_THUNDER_ECAM=y
 CONFIG_ARM64_VA_BITS_48=y
 CONFIG_SCHED_MC=y
 CONFIG_NUMA=y
@@ -188,6 +190,7 @@ CONFIG_VIRTIO_NET=y
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_MACB=y
+CONFIG_THUNDER_NIC_PF=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
 CONFIG_E1000E=y
-- 
2.13.4.dirty
