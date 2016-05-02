From: carlo@caione.org (Carlo Caione)
Date: Mon,  2 May 2016 10:02:17 +0200
Subject: [PATCH v2 3/4] ARM64: Kconfig: Select the Amlogic Meson pin
 controller driver
In-Reply-To: <1462176138-29433-1-git-send-email-carlo@caione.org>
References: <1462176138-29433-1-git-send-email-carlo@caione.org>
Message-ID: <1462176138-29433-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Select the Meson pin controller driver also for the AArch64 Meson
platform.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 54967ff..fc051f0 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -65,6 +65,8 @@ config ARCH_MEDIATEK
 
 config ARCH_MESON
 	bool "Amlogic Platforms"
+	select PINCTRL
+	select PINCTRL_MESON
 	help
 	  This enables support for the Amlogic S905 SoCs.
 
-- 
2.7.4
