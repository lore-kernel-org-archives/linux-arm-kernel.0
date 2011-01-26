From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 25 Jan 2011 21:44:06 -0700
Subject: [RFC PATCH 1/5] arm/dt: Add dt machine definition
In-Reply-To: <20110126043338.16410.75019.stgit@localhost6.localdomain6>
References: <20110126043338.16410.75019.stgit@localhost6.localdomain6>
Message-ID: <20110126044406.16410.22096.stgit@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/include/asm/mach/arch.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 2ed24e7..13c0e69 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -67,4 +67,13 @@ static const struct machine_desc __mach_desc_##_type	\
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
