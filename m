From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 01 May 2011 23:07:45 -0600
Subject: [RFC PATCH 1/4] arm/dt: Add dt machine definition
In-Reply-To: <20110502045207.24800.91172.stgit@ponder>
References: <20110502045207.24800.91172.stgit@ponder>
Message-ID: <20110502050745.24800.32800.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a DT_MACHINE_START macro to use instead of
MACHINE_START when creating a machine_desc that supports using the
device tree.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/include/asm/mach/arch.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 946f4d7..858d269 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -70,4 +70,13 @@ static const struct machine_desc __mach_desc_##_type	\
 #define MACHINE_END				\
 };
 
+#define MACH_TYPE_DT	0xffffffff
+
+#define DT_MACHINE_START(_name, _namestr)		\
+static const struct machine_desc __mach_desc_##_name	\
+ __used							\
+ __attribute__((__section__(".arch.info.init"))) = {	\
+	.nr		= MACH_TYPE_DT,			\
+	.name		= _namestr,
+
 #endif
