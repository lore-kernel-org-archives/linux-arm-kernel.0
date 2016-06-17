From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Jun 2016 12:31:23 +0200
Subject: [PATCH 1/2] ARM: qcom: Add support for MDM9615
In-Reply-To: <1466159484-21858-1-git-send-email-narmstrong@baylibre.com>
References: <1466159484-21858-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1466159484-21858-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Qualcomm MDM9615 in Kconfig and in DT match list.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-qcom/Kconfig | 4 ++++
 arch/arm/mach-qcom/board.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 7349450..46ed10a 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -23,4 +23,8 @@ config ARCH_MSM8974
 	bool "Enable support for MSM8974"
 	select HAVE_ARM_ARCH_TIMER
 
+config ARCH_MDM9615
+	bool "Enable support for MDM9615"
+	select CLKSRC_QCOM
+
 endif
diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
index 6d8bbf7..d8060df 100644
--- a/arch/arm/mach-qcom/board.c
+++ b/arch/arm/mach-qcom/board.c
@@ -22,6 +22,7 @@ static const char * const qcom_dt_match[] __initconst = {
 	"qcom,ipq8064",
 	"qcom,msm8660-surf",
 	"qcom,msm8960-cdp",
+	"qcom,mdm9615",
 	NULL
 };
 
-- 
1.9.1
