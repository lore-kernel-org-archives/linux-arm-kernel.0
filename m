From: jiri.pinkava@vscht.cz (jiri.pinkava at vscht.cz)
Date: Wed, 6 Apr 2011 01:06:03 +0200
Subject: [PATCH 1/6] n35: Fix key code values for some GPIO keys.
In-Reply-To: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
References: <1302044768-7774-1-git-send-email-jiri.pinkava@vscht.cz>
Message-ID: <1302044768-7774-2-git-send-email-jiri.pinkava@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiri Pinkava <jiri.pinkava@vscht.cz>

KEY_POWER is ordinary button, type PWR is invalid.

Someone copy-pasted code for GPIO keys and forget change code values.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index 66f4444..4f3413b 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -158,7 +158,6 @@ static struct gpio_keys_button n35_buttons[] = {
 	{
 		.gpio		= S3C2410_GPF(0),
 		.code		= KEY_POWER,
-		.type		= EV_PWR,
 		.desc		= "Power",
 		.active_low	= 0,
 		.wakeup		= 1,
@@ -177,13 +176,13 @@ static struct gpio_keys_button n35_buttons[] = {
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
1.7.4.2
