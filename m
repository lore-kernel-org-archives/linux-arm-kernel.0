From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Thu, 14 Jul 2011 15:07:16 +0530
Subject: [PATCH 2/2] ARM: pxa168: gplugD: bug-fix: Free correct GPIO
In-Reply-To: <no>
References: <no>
Message-ID: <1310636236-3104-2-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
---
 arch/arm/mach-mmp/gplugd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 0770e51..98e25d9 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -162,7 +162,7 @@ static void __init select_disp_freq(void)
 				"frequency\n");
 	} else {
 		gpio_direction_output(35, 1);
-		gpio_free(104);
+		gpio_free(35);
 	}
 
 	if (unlikely(gpio_request(85, "DISP_FREQ_SEL_2"))) {
@@ -170,7 +170,7 @@ static void __init select_disp_freq(void)
 				"frequency\n");
 	} else {
 		gpio_direction_output(85, 0);
-		gpio_free(104);
+		gpio_free(85);
 	}
 }
 
-- 
1.7.0.4
