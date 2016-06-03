From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri,  3 Jun 2016 08:18:23 +0200
Subject: [PATCH v2 4/9] arm64: Add platform selection for BCM2835.
In-Reply-To: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464934708-24769-5-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Anholt <eric@anholt.net>

Signed-off-by: Eric Anholt <eric@anholt.net>

[ kraxel: copy some selects from arm to arm64 ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm64/Kconfig.platforms | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7ef1d05..ea88402 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -13,6 +13,19 @@ config ARCH_ALPINE
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
 
+config ARCH_BCM2835
+	bool "Broadcom BCM2835 family"
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKSRC_OF
+	select PINCTRL
+	select PINCTRL_BCM2835
+	select ARM_AMBA
+	select ARM_TIMER_SP804
+	select HAVE_ARM_ARCH_TIMER
+	help
+	  This enables support for the Broadcom BCM2837 SoC.
+	  This SoC is used in the Raspberry Pi 3 device.
+
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
 	select COMMON_CLK_IPROC
-- 
1.8.3.1
