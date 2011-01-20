From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:55:40 +0530
Subject: [PATCH V5 01/63] spear/vmalloc.h: Appending UL to VMALLOC_END
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <5e12474cf3913556a8cd4c4484a7884cebb60db2.1295499394.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes following warning:
mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but
argument 12 has type 'unsigned int'

by appending UL to VMALLOC_END's Number.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/include/plat/vmalloc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/vmalloc.h b/arch/arm/plat-spear/include/plat/vmalloc.h
index 09e9372..8c8b24d 100644
--- a/arch/arm/plat-spear/include/plat/vmalloc.h
+++ b/arch/arm/plat-spear/include/plat/vmalloc.h
@@ -14,6 +14,6 @@
 #ifndef __PLAT_VMALLOC_H
 #define __PLAT_VMALLOC_H
 
-#define VMALLOC_END		0xF0000000
+#define VMALLOC_END		0xF0000000UL
 
 #endif /* __PLAT_VMALLOC_H */
-- 
1.7.3.4
