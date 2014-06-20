From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Jun 2014 16:35:52 +0200
Subject: [PATCH v2 1/2] ARM: mvebu: Use the a standard errno in
 mvebu_get_soc_id
In-Reply-To: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403274953-21790-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403274953-21790-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of using -1 as error value, use a standard errno.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/mvebu-soc-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index d0f35b4d4a23..12c66cac967d 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -51,7 +51,7 @@ int mvebu_get_soc_id(u32 *dev, u32 *rev)
 		*rev = soc_rev;
 		return 0;
 	} else
-		return -1;
+		return -ENODEV;
 }
 
 static int __init mvebu_soc_id_init(void)
-- 
1.8.1.2
