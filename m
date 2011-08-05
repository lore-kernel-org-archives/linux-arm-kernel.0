From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 5 Aug 2011 15:32:26 +0530
Subject: [PATCH V3 01/20] ARM: asm/pl080.h: Protect against multiple inclusion
	of header file
In-Reply-To: <cover.1312538034.git.viresh.kumar@st.com>
References: <cover.1312538034.git.viresh.kumar@st.com>
Message-ID: <4197035d67eead4da9eaf253ed6eca9d5630b544.1312538034.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<asm/hardware/pl080.h> doesn't have protection to deal with multiple inclusion.
And so we get compilation errors in cases where this file is included more than
once. This patch adds #ifdefs at the top of file to protect it against multiple
inclusions.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/hardware/pl080.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/pl080.h b/arch/arm/include/asm/hardware/pl080.h
index e4a04e4..33c78d7 100644
--- a/arch/arm/include/asm/hardware/pl080.h
+++ b/arch/arm/include/asm/hardware/pl080.h
@@ -21,6 +21,9 @@
  * OneNAND features.
 */
 
+#ifndef ASM_PL080_H
+#define ASM_PL080_H
+
 #define PL080_INT_STATUS			(0x00)
 #define PL080_TC_STATUS				(0x04)
 #define PL080_TC_CLEAR				(0x08)
@@ -138,3 +141,4 @@ struct pl080s_lli {
 	u32	control1;
 };
 
+#endif /* ASM_PL080_H */
-- 
1.7.2.2
