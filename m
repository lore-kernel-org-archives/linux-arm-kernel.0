From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:21 +0900
Subject: [PATCH 4/5] ARM: shmobile: Enable MICREL_PHY in shmobile_defconfig
In-Reply-To: <cover.1419808942.git.horms+renesas@verge.net.au>
References: <cover.1419808942.git.horms+renesas@verge.net.au>
Message-ID: <174b7a54c925a068161222fadb45732453bd7efa.1419808942.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1c9106cb783cd227 ("ARM: shmobile: lager-reference: DTS-only board
support"), dropped the MACH_LAGER Kconfig section, which did "select
MICREL_PHY if SH_ETH". Hence we now have to enable MICREL_PHY explicitly
in shmobile_defconfig.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index a936a2e..a9a1b0af 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -80,6 +80,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_VIA is not set
 # CONFIG_NET_VENDOR_WIZNET is not set
 CONFIG_SMSC_PHY=y
+CONFIG_MICREL_PHY=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
-- 
2.1.3
