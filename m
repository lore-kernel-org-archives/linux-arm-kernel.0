From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Fri, 9 Nov 2018 02:07:07 +0100
Subject: [PATCH v3 7/9] arm64: defconfig: Enable FSL_MC_BUS and FSL_MC_DPIO
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <beb32683-fbd0-fc17-8e71-4f4f51163223@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
which is not set. Enable FSL_MC_BUS, and build FSL_MC_DPIO and
CRYPTO_DEV_FSL_DPAA2_CAAM as modules.

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8e181cca0a05..2662f83c481c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -200,6 +200,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
+CONFIG_FSL_MC_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -631,6 +632,7 @@ CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_FSL_MC_DPIO=m
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
@@ -718,6 +720,7 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_SECURITY=y
 CONFIG_CRYPTO_ECHAINIV=y
 CONFIG_CRYPTO_ANSI_CPRNG=y
+CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
@@ -727,4 +730,3 @@ CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
-CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=y
-- 
2.8.2
