From: wni@nvidia.com (Wei Ni)
Date: Wed, 4 Jul 2012 17:34:48 +0800
Subject: [PATCH 5/5] ARM: tegra: enable wireless in defconfig
In-Reply-To: <1341394488-13169-1-git-send-email-wni@nvidia.com>
References: <1341394488-13169-1-git-send-email-wni@nvidia.com>
Message-ID: <1341394488-13169-6-git-send-email-wni@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New options enabled:
* WIRELESS: (dependency)
* CFG80211: (dependency)
* WLAN: (dependency)
* BRCMFMAC: wlan driver, enable as module.

Signed-off-by: Wei Ni <wni@nvidia.com>
---
 arch/arm/configs/tegra_defconfig |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 4be9c1e..c0aa6d9 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -67,7 +67,8 @@ CONFIG_INET6_IPCOMP=y
 CONFIG_IPV6_MIP6=y
 CONFIG_IPV6_TUNNEL=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
-# CONFIG_WIRELESS is not set
+CONFIG_WIRELESS=y
+CONFIG_CFG80211=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
@@ -87,7 +88,8 @@ CONFIG_USB_PEGASUS=y
 CONFIG_USB_USBNET=y
 CONFIG_USB_NET_SMSC75XX=y
 CONFIG_USB_NET_SMSC95XX=y
-# CONFIG_WLAN is not set
+CONFIG_WLAN=y
+CONFIG_BRCMFMAC=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MPU3050=y
-- 
1.7.1
