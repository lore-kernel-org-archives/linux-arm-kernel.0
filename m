From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Sat, 31 Oct 2009 04:00:51 -0400 (EDT)
Subject: [PATCH] ARM/S3C2440:  Add spaces around case range operands.
Message-ID: <alpine.LFD.2.00.0910310359260.24643@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


For safety, add spaces around the case range operator "..." since it
might be parsed incorrectly when used with integer values.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index ec71a69..f6ee17c 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -582,7 +582,7 @@ static void mini2440_parse_features(
 		char f = *fp++;

 		switch (f) {
-		case '0'...'9':	/* tft screen */
+		case '0' ... '9':	/* tft screen */
 			if (features->done & FEATURE_SCREEN) {
 				printk(KERN_INFO "MINI2440: '%c' ignored, "
 					"screen type already set\n", f);

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
