From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 21 Jun 2017 12:30:47 -0500
Subject: [PATCH 8/8] [v2] arm64: defconfig: enable Qualcomm Technologies EMAC
 and some PHY drivers
In-Reply-To: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
References: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
Message-ID: <1498066247-22130-9-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EMAC is present on Qualcomm Technologies' server and some mobile
chips, and is used as the primary Ethernet interface.

Systems that have these SOCs typically have an Atheros 803x or
Marvell 88e1111 PHY in them, so enable those drivers too.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 00a0f80..854ed3f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -192,11 +192,14 @@ CONFIG_IGBVF=y
 CONFIG_MVNETA=y
 CONFIG_MVPP2=y
 CONFIG_SKY2=y
+CONFIG_QCOM_EMAC=m
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=m
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
+CONFIG_AT803X_PHY=m
+CONFIG_MARVELL_PHY=m
 CONFIG_MESON_GXL_PHY=m
 CONFIG_MICREL_PHY=y
 CONFIG_REALTEK_PHY=m
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
