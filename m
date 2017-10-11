From: nicolas.dechesne@linaro.org (Nicolas Dechesne)
Date: Wed, 11 Oct 2017 17:19:25 +0200
Subject: [PATCH] arm64: defconfig: Enable QCOM_IOMMU
Message-ID: <20171011151925.30909-1-nicolas.dechesne@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable QCOM IOMMU driver for 'B' family devices, such as APQ8016 found on the
Dragonboard 410c. With this change, graphics console and GPU are working
fine (using mesa/freedreno for GPU driver).

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34480e9af2e7..653f7149179a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -510,6 +510,7 @@ CONFIG_HI6220_MBOX=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
+CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_QCOM_SMEM=y
-- 
2.14.2
