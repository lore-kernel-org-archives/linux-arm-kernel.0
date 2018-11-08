From: horia.geanta@nxp.com (Horia Geanta)
Date: Thu, 8 Nov 2018 11:38:10 +0000
Subject: [PATCH 7/9] arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
 <e6e0105f-3135-e5b7-8224-419c9f730a09@free.fr>
 <85a73243-0c53-43e5-5002-90631c0a8c90@free.fr>
 <VI1PR0402MB3485342DB8A0F5C5791E213798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Message-ID: <VI1PR0402MB348569B15DBAB6503303D41798C50@VI1PR0402MB3485.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/8/2018 1:23 PM, Horia Geanta wrote:
> On 11/7/2018 10:49 PM, Marc Gonzalez wrote:
>> [ Add interested parties ]
>>
>> On 07/11/2018 21:18, Marc Gonzalez wrote:
>>
>>> Commit e8342cc7954e ("enable CAAM crypto engine on QorIQ DPAA2 SoCs")
>>> enabled CRYPTO_DEV_FSL_DPAA2_CAAM, which depends on FSL_MC_DPIO,
>>> which is not set.
>>>
> Thanks Marc.
> 
> Though I would prefer enabling the dependencies:
> dpaa2-caam driver -> dpio driver (FSL_MC_DPIO) -> fsl-mc driver (FSL_MC_BUS).
> 
Could you instead incorporate below patch in your series?
(I am pretty sure it won't apply clean)

Thanks,
Horia

-- >8 --

Subject: [PATCH] arm64: defconfig: enable DPAA2 fsl-mc bus and DPIO driver

Enable fsl-mc bus and DPIO (Datapath I/O) driver, which are needed on
Layerscape SoCs with QorIQ Data Path Acceleration Architecture (DPAA) v2.

Suggested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d11330b..7c3785e61ef9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -181,6 +181,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
+CONFIG_FSL_MC_BUS=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -615,6 +616,7 @@ CONFIG_QCOM_IOMMU=y
 CONFIG_RPMSG_QCOM_GLINK_RPM=y
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_FSL_MC_DPIO=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
-- 
2.16.2
