From: anup.patel@broadcom.com (Anup Patel)
Date: Wed, 10 Feb 2016 11:40:46 +0530
Subject: [PATCH 1/6] arm64: Select COMMON_CLK_IPROC,
 PINCTRL and GPIOLIB for iProc SoCs
In-Reply-To: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
References: <1455084651-29325-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1455084651-29325-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We select COMMON_CLK_IPROC, PINCTRL, and GPIOLIB in arm64 Kconfig
for ARCH_BCM_IPROC so that we can use COMMON_CLK, PINCTRL and GPIOLIB
with iProc SoC drivers.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Ray Jui <rjui@broadcom.com>
Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
---
 arch/arm64/Kconfig.platforms | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f6..e20b50c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -2,6 +2,9 @@ menu "Platform selection"
 
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
+	select COMMON_CLK_IPROC
+	select PINCTRL
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  This enables support for Broadcom iProc based SoCs
 
-- 
1.9.1
