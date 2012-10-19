From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 19 Oct 2012 14:53:57 -0700
Subject: [PATCH 4/7] ARM: OMAP2+: Remove unnecessary message when no SHA IP is
 present
In-Reply-To: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <1350683640-15044-5-git-send-email-mgreer@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>

Remove the error message that prints when there is no SHA IP
present to make it consistent with all the other IPs.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/devices.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 40211de..8784812 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -472,8 +472,6 @@ static void __init omap_init_sham(void)
 		pdev = omap_device_build("omap-sham", -1, oh, NULL, 0, NULL,
 					 0, 0);
 		WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
-	} else {
-		pr_err("%s: platform not supported\n", __func__);
 	}
 }
 
-- 
1.7.12
