From: heiko@sntech.de (Heiko Stuebner)
Date: Wed,  9 May 2018 16:32:25 +0200
Subject: [PATCH] arm64: defconfig: enable rockchip efuse
Message-ID: <20180509143225.32596-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The efuses on Rockchip socs often contain informations
about specifics of the chip its running on (leakage currents etc)
which components might want to read to adjust settings accordingly.

So enable the efuse early for that.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34037d24fbf4..74abf140e332 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -612,6 +612,7 @@ CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
 CONFIG_MESON_EFUSE=m
 CONFIG_QCOM_QFPROM=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-- 
2.16.2
