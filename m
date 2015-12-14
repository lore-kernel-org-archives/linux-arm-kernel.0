From: nm@ti.com (Nishanth Menon)
Date: Mon, 14 Dec 2015 12:43:00 -0600
Subject: [PATCH V2 3/3] ARM: multi_v7_defconfig: Enable generic SoC internal
 OMAP regulators
In-Reply-To: <1450118580-24754-1-git-send-email-nm@ti.com>
References: <1450118580-24754-1-git-send-email-nm@ti.com>
Message-ID: <1450118580-24754-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ABB and PBIAS are internal LDO control regulators that are needed for
maintaining proper functionality of OMAP architecture SoCs. Enable the
same. PBIAS is already enabled, so just enable ABB regulator as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/configs/multi_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f8b61b7abc41..eba026af7f90 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -440,6 +440,7 @@ CONFIG_REGULATOR_QCOM_RPM=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
 CONFIG_REGULATOR_S2MPS11=y
 CONFIG_REGULATOR_S5M8767=y
+CONFIG_REGULATOR_TI_ABB=y
 CONFIG_REGULATOR_TPS51632=y
 CONFIG_REGULATOR_TPS62360=y
 CONFIG_REGULATOR_TPS65090=y
-- 
1.7.9.5
