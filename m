From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 25 May 2013 15:42:18 +0900
Subject: [PATCH] ARM: shmobile: sh73a0: Update CMT clockevent rating to 80
In-Reply-To: <1369464138-21530-1-git-send-email-horms+renesas@verge.net.au>
References: <1369464138-21530-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369464138-21530-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the CMT clockevent rating from 125 to 80.

This resolves a boot-failure regression for kzm9g-reference in v3.10-rc1
introduced by f7db706b132f11c79ae1d74b2382e0926cf31644 ("ARM: 7674/1: smp:
Avoid dummy clockevent being preferred over real").

The patch noted above reduces the rating of dummy clockevent from 400 to 100.
This patch reduces the rating of CMT so that it is once again less than that
of the dummy clockevent.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index fdf3894..9696f36 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -252,7 +252,7 @@ static struct sh_timer_config cmt10_platform_data = {
 	.name = "CMT10",
 	.channel_offset = 0x10,
 	.timer_bit = 0,
-	.clockevent_rating = 125,
+	.clockevent_rating = 80,
 	.clocksource_rating = 125,
 };
 
-- 
1.7.10.4
