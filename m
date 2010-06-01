From: saeed@marvell.com (Saeed Bishara)
Date: Tue,  1 Jun 2010 18:09:26 +0300
Subject: [PATCH 1/3] [ARM] Kirkwood: add support for rev A1 of the 88f6192 and
	88f6180 chips.
Message-ID: <1275404968-12258-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mach-kirkwood/common.c                |    4 ++++
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 6072eaa..c780c4a 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -891,11 +891,15 @@ static char * __init kirkwood_id(void)
 			return "MV88F6192-Z0";
 		else if (rev == MV88F6192_REV_A0)
 			return "MV88F6192-A0";
+		else if (rev == MV88F6192_REV_A1)
+			return "MV88F6192-A1";
 		else
 			return "MV88F6192-Rev-Unsupported";
 	} else if (dev == MV88F6180_DEV_ID) {
 		if (rev == MV88F6180_REV_A0)
 			return "MV88F6180-Rev-A0";
+		else if (rev == MV88F6180_REV_A1)
+			return "MV88F6180-Rev-A1";
 		else
 			return "MV88F6180-Rev-Unsupported";
 	} else {
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index a15cf0e..d61b9aa 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -107,8 +107,10 @@
 #define MV88F6192_DEV_ID	0x6192
 #define MV88F6192_REV_Z0	0
 #define MV88F6192_REV_A0	2
+#define MV88F6192_REV_A1	3
 
 #define MV88F6180_DEV_ID	0x6180
 #define MV88F6180_REV_A0	2
+#define MV88F6180_REV_A1	3
 
 #endif
-- 
1.6.0.4
