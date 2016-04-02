From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat,  2 Apr 2016 19:47:54 +0800
Subject: [PATCH v3 4/4] arm64: defconfig: enable configs for WLAN and TI
 WL1835 as modules
In-Reply-To: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
References: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459597674-6834-5-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables TI WL1835 and builds as module. It also enables
CFG80211, MAC80211, RFKILL and several CRYPTOs which are required
by WLAN.

96boards HiKey uses TI WLAN/BT combo module WL1835MOD.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/configs/defconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f31a44f..aa1909d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -83,7 +83,10 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_LRO is not set
 # CONFIG_IPV6 is not set
 CONFIG_BPF_JIT=y
-# CONFIG_WIRELESS is not set
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
+CONFIG_MAC80211_LEDS=y
+CONFIG_RFKILL=m
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -127,7 +130,8 @@ CONFIG_USB_NET_SMSC75XX=m
 CONFIG_USB_NET_SMSC95XX=m
 CONFIG_USB_NET_PLUSB=m
 CONFIG_USB_NET_MCS7830=m
-# CONFIG_WLAN is not set
+CONFIG_WL18XX=m
+CONFIG_WLCORE_SDIO=m
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_SERIO_SERPORT is not set
-- 
1.9.1
