From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Aug 2016 23:42:08 +0800
Subject: [PATCH 4/4] arm64: defconfig: enable bluetooth supports as modules
In-Reply-To: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
References: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1471621328-21102-5-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the following items for bluetooth mouse and speaker which base
on HCIUART.

a) CONFIG_BT_HCIUART
b) CONFIG_BT_HCIUART_LL
c) CONFIG_BT_HIDP

Enable bluetooth LED support.

d) CONFIG_BT_LEDS

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 11a79ba..30b6220 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -120,6 +120,14 @@ CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
 CONFIG_BPF_JIT=y
+CONFIG_BT=m
+CONFIG_BT_HIDP=m
+# CONFIG_BT_HS is not set
+# CONFIG_BT_LE is not set
+CONFIG_BT_LEDS=y
+# CONFIG_BT_DEBUGFS is not set
+CONFIG_BT_HCIUART=m
+CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
 CONFIG_MAC80211_LEDS=y
-- 
1.9.1
