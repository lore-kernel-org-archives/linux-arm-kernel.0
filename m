From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jul 2018 14:04:18 +0200
Subject: [PATCH 1/5] ARM: shmobile: defconfig: Drop NET_VENDOR_<FOO>=n
In-Reply-To: <cover.1532346690.git.horms+renesas@verge.net.au>
References: <cover.1532346690.git.horms+renesas@verge.net.au>
Message-ID: <49141c8248505bd45e77dd7673a952a14f8fd390.1532346690.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enabling NET_VENDOR_* Kconfig options does not directly affect the
kernel, so there is no need to explicitly disable them.
The individual network drivers under them are still disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b49887e86a3d..e30e51809cfc 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -72,22 +72,9 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
 CONFIG_NETDEVICES=y
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
 CONFIG_SH_ETH=y
 CONFIG_RAVB=y
-# CONFIG_NET_VENDOR_SEEQ is not set
 CONFIG_SMSC911X=y
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_MICREL_PHY=y
 CONFIG_SMSC_PHY=y
 CONFIG_INPUT_EVDEV=y
-- 
2.11.0
