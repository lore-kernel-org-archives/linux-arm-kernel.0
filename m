From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 20 Jul 2017 10:18:15 +0530
Subject: [PATCH v2 1/5] arm64: qcom: Select PM_GENERIC_DOMAINS
In-Reply-To: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1500526099-9935-2-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable PM_GENERIC_DOMAINS for 64-bit qualcomm platforms. This is required
to ensure devices which are dependent on some gdscs (powerdomains) to be
powered on before they can be probed, work as expected.

CC: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index f5f0c81..e3de82d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -133,6 +133,8 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
