From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 21 Mar 2017 11:45:19 +0530
Subject: [PATCH 1/5] arm64: qcom: Select PM_GENERIC_DOMAINS
In-Reply-To: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
References: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1490076923-20194-2-git-send-email-rnayak@codeaurora.org>
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
index 129cc5a..c5ae2cf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -115,6 +115,8 @@ config ARCH_QCOM
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
