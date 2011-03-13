From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 13 Mar 2011 17:19:22 +0200
Subject: [PATCH v2 6/6] ARM: PXA: Z2: Use switch event for lid
In-Reply-To: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
References: <1300029562-8400-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1300029562-8400-7-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise userspace might be confused.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-pxa/z2.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 5869f65..3d3f019 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -435,12 +435,12 @@ static struct gpio_keys_button z2_pxa_buttons[] = {
 		.type		= EV_KEY,
 	},
 	{
-		.code		= KEY_CLOSE,
+		.code		= SW_LID,
 		.gpio		= GPIO98_ZIPITZ2_LID_BUTTON,
-		.active_low	= 0,
-		.desc		= "Lid Button",
-		.wakeup		= 0
-		.type		= EV_KEY,
+		.active_low	= 1,
+		.desc		= "Lid Switch",
+		.wakeup		= 0,
+		.type		= EV_SW,
 	},
 };
 
-- 
1.7.4.1
