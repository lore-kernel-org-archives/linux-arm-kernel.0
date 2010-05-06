From: Jiri.Pinkava@vscht.cz (Pinkava J.)
Date: Thu, 6 May 2010 15:21:50 +0200
Subject: [PATCH 5/8] Enable wake-up by Power button on Acer n35
In-Reply-To: <4BE2C24C.9050008@vscht.cz>
References: <4BE1EBFE.9080601@vscht.cz> <4BE1ED3E.1050201@vscht.cz>
	<4BE1ED86.3010506@vscht.cz> <4BE1EE5F.5090402@vscht.cz>
	<4BE1EE8C.8040900@vscht.cz>
	<20100506012258.GZ6684@trinity.fluff.org>
	<4BE2C18E.6080207@vscht.cz> <4BE2C1D7.4030408@vscht.cz>
	<4BE2C224.7080907@vscht.cz> <4BE2C24C.9050008@vscht.cz>
Message-ID: <4BE2C26E.2080508@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
 arch/arm/mach-s3c2410/mach-n30.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-n30.c b/arch/arm/mach-s3c2410/mach-n30.c
index b83eabd..d63b48f 100644
--- a/arch/arm/mach-s3c2410/mach-n30.c
+++ b/arch/arm/mach-s3c2410/mach-n30.c
@@ -172,8 +172,10 @@ static struct gpio_keys_button n35_buttons[] = {
 	{
 		.gpio		= S3C2410_GPF(0),
 		.code		= KEY_POWER,
+		.type		= EV_PWR,
 		.desc		= "Power",
 		.active_low	= 0,
+		.wakeup		= 1,
 	},
 	{
 		.gpio		= S3C2410_GPG(9),
-- 
1.7.1
