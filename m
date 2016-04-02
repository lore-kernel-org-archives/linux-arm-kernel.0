From: guodong.xu@linaro.org (Guodong Xu)
Date: Sat,  2 Apr 2016 19:47:53 +0800
Subject: [PATCH v3 3/4] arm64: defconfig: enable several common USB network
 adapters
In-Reply-To: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
References: <1459597674-6834-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459597674-6834-4-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Akira Tsukamoto <akira.tsukamoto@linaro.org>

The arm64 system is likely to be used as a host computer instead of
embedded devices and adding USB-Ethernet dongles to make it behave as
host PC is mandatory.

Changelog:
v2: Changed drivers to be as modules instead of built-in.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/configs/defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e4952c5..f31a44f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -117,6 +117,16 @@ CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 CONFIG_MICREL_PHY=y
+CONFIG_USB_PEGASUS=m
+CONFIG_USB_RTL8150=m
+CONFIG_USB_RTL8152=m
+CONFIG_USB_USBNET=m
+CONFIG_USB_NET_DM9601=m
+CONFIG_USB_NET_SR9800=m
+CONFIG_USB_NET_SMSC75XX=m
+CONFIG_USB_NET_SMSC95XX=m
+CONFIG_USB_NET_PLUSB=m
+CONFIG_USB_NET_MCS7830=m
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
-- 
1.9.1
