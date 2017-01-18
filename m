From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Jan 2017 15:27:23 -0800
Subject: [PATCH 2/5] ARM: Makefile: Generalize qcom platform text offset
In-Reply-To: <20170118232726.22876-1-sboyd@codeaurora.org>
References: <20170118232726.22876-1-sboyd@codeaurora.org>
Message-ID: <20170118232726.22876-3-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some qcom platforms need a specific text offset because the first
2MB of memory is reserved for shared memory. Let's just always
shift the text segment up by 2MB when ARCH_QCOM is selected so
that we don't have to specify the specific platforms that exhibit
this problem in Kconfig.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ab30cc634d02..8a6d344e6043 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -145,8 +145,7 @@ textofs-$(CONFIG_PM_H1940)      := 0x00108000
 ifeq ($(CONFIG_ARCH_SA1100),y)
 textofs-$(CONFIG_SA1111) := 0x00208000
 endif
-textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
-textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
+textofs-$(CONFIG_ARCH_QCOM) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
