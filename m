From: marex@denx.de (Marek Vasut)
Date: Wed, 19 Dec 2012 18:33:05 +0100
Subject: [PATCH 7/8] arm: mxs: Enable support for most SPI flashes
In-Reply-To: <1355938386-14582-1-git-send-email-marex@denx.de>
References: <1355938386-14582-1-git-send-email-marex@denx.de>
Message-ID: <1355938386-14582-8-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for most SPI flashes, usually M25P80. They're used
on MX28 designs a lot.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 0b7e466..2948fec 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -54,6 +54,9 @@ CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_DATAFLASH=y
+CONFIG_MTD_M25P80=y
+# CONFIG_M25PXX_USE_FAST_READ is not set
+CONFIG_MTD_SST25L=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_MTD_UBI=y
-- 
1.7.10.4
