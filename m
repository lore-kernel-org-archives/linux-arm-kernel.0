From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  6 Dec 2013 10:41:18 +0900
Subject: [PATCH 1/2] ARM: shmobile: kzm9g: Enable SMSC_PHY in defconfig
In-Reply-To: <1386294079-16392-1-git-send-email-horms+renesas@verge.net.au>
References: <1386294079-16392-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1386294079-16392-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kzm9g board uses has an SMSC 9221 ethernet controller
which includes an integrated phy. Enable SMSC_PHY in the defconfig
to make use of the SMSC-specific phy driver rather than
relying on the generic phy driver.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 9934dbc2..2a55951 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -64,6 +64,7 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
 CONFIG_SMSC911X=y
+CONFIG_SMSC_PHY=y
 # CONFIG_WLAN is not set
 CONFIG_INPUT_SPARSEKMAP=y
 # CONFIG_INPUT_MOUSEDEV is not set
-- 
1.8.4
