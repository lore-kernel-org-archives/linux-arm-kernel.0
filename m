From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 30 Nov 2015 18:00:11 +0100
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: enable PCI_MSI
In-Reply-To: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
References: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This has been stable on i.MX6 for a good while now and there is no
reason to keep it disabled, as it allows to allocate non-shared
IRQs if several PCIe devices are connected to a single host.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4187f69f6630..e2ce60d00e8a 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -45,6 +45,7 @@ CONFIG_SOC_IMX7D=y
 CONFIG_SOC_LS1021A=y
 CONFIG_SOC_VF610=y
 CONFIG_PCI=y
+CONFIG_PCI_MSI=y
 CONFIG_PCI_IMX6=y
 CONFIG_SMP=y
 CONFIG_PREEMPT_VOLUNTARY=y
-- 
2.6.2
