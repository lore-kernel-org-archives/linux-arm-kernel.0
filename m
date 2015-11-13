From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 13 Nov 2015 12:04:14 +0800
Subject: [PATCH v2 8/9] ARM: sunxi_defconfig: Update MFD_AXP20X symbol and
 enable MFD_AXP20X_RSB
In-Reply-To: <1447387456-9912-1-git-send-email-wens@csie.org>
References: <1447387456-9912-1-git-send-email-wens@csie.org>
Message-ID: <1447387456-9912-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

axp20x support has been split into 2 parts, I2C and RSB interface
variants.

Update the MFD_AXP20X symbol for I2C support, and also enable
MFD_AXP20X_RSB to support RSB variants.

Keep MFD_AXP20X enabled for now, to ease migration for automated boot
farms while the patches are being merged. This should be removed in the
next release.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/sunxi_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 3c36e16fcacf..18dbfaddb727 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -89,6 +89,8 @@ CONFIG_CPU_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SUNXI_WATCHDOG=y
 CONFIG_MFD_AXP20X=y
+CONFIG_MFD_AXP20X_I2C=y
+CONFIG_MFD_AXP20X_RSB=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_AXP20X=y
-- 
2.6.2
