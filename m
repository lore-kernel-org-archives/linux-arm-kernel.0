From: Jiri.Pinkava@vscht.cz (Jiri.Pinkava at vscht.cz)
Date: Wed, 13 Oct 2010 09:56:17 +0200
Subject: [PATCH 1/6] n35: fix key codes
In-Reply-To: <4CA91E6F.3010704@vscht.cz>
References: <4CA91E6F.3010704@vscht.cz>
Message-ID: <1286956582-15586-1-git-send-email-jiri.pinkava@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Power is ordinary button, marking as type EV_POWER is incorrect.

About KEY_DOWN, someone just copied the code and forgot to asociate proper
keycodes. (Descriptions are correct, keycodes are not.)


Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 41f299d..e732619 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -174,7 +174,6 @@ static struct gpio_keys_button n35_buttons[] = {
 	{
 		.gpio		= S3C2410_GPF(0),
 		.code		= KEY_POWER,
-		.type		= EV_PWR,
 		.desc		= "Power",
 		.active_low	= 0,
 		.wakeup		= 1,
@@ -193,13 +192,13 @@ static struct gpio_keys_button n35_buttons[] = {
 	},
 	{
 		.gpio		= S3C2410_GPG(6),
-		.code		= KEY_DOWN,
+		.code		= KEY_LEFT,
 		.desc		= "Joystick Left",
 		.active_low	= 0,
 	},
 	{
 		.gpio		= S3C2410_GPG(5),
-		.code		= KEY_DOWN,
+		.code		= KEY_RIGHT,
 		.desc		= "Joystick Right",
 		.active_low	= 0,
 	},
-- 
1.7.3.1
