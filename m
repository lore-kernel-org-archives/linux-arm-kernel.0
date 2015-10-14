From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 14 Oct 2015 16:02:50 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: improve multi_v7_defconfig support
 for Berlin
Message-ID: <1444831370-25688-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some drivers used on a Marvell Berlin kernel were missing from
multi_v7_defconfig. This series add them:

  * The pxa168 Ethernet driver is added as a loadable module.
  * The Berlin ADC driver is added as a loadable module.
  * Both the Berlin USB PHY and SATA PHY drivers are added,
    built-in, as they are required for the already available USB
    and SATA functionalities in multi_v7_defconfig.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---

Hi,

That's actually a v2 of the series "ARM: berlin: improve multi_v7_defconfig
support" I sent earlier. I've squashed all 4 commits into a single one and
updated to use loadable modules when possible in this v2.

Antoine

 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 03deb7fb35e8..6b021368fbd5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -207,6 +207,7 @@ CONFIG_NET_CALXEDA_XGMAC=y
 CONFIG_IGB=y
 CONFIG_MV643XX_ETH=y
 CONFIG_MVNETA=y
+CONFIG_PXA168_ETH=m
 CONFIG_KS8851=y
 CONFIG_R8169=y
 CONFIG_SH_ETH=y
@@ -636,6 +637,7 @@ CONFIG_EXTCON=y
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
 CONFIG_AT91_ADC=m
+CONFIG_BERLIN2_ADC=m
 CONFIG_EXYNOS_ADC=m
 CONFIG_XILINX_XADC=y
 CONFIG_AK8975=y
@@ -651,6 +653,8 @@ CONFIG_PHY_HIX5HD2_SATA=y
 CONFIG_PWM_STI=m
 CONFIG_OMAP_USB2=y
 CONFIG_TI_PIPE3=y
+CONFIG_PHY_BERLIN_USB=y
+CONFIG_PHY_BERLIN_SATA=y
 CONFIG_PHY_MIPHY28LP=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_RCAR_GEN2=m
-- 
2.6.1
