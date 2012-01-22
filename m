From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:37 +0100
Subject: [RFC PATCH 11/11] HACK! ARM: no, we don't enter in ARM
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-11-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... as a Cortex-M3 can only do Thumb-2 ...

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
This probably needs a new Kconfig symbol as THUMB2_KERNEL doesn't have
the right meaning. Something like "CPU_THUMB_ONLY"?
---
 arch/arm/kernel/head-nommu.S |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index dba31af..bb94ce4 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -32,13 +32,14 @@
  * numbers for r1.
  *
  */
-	.arm
+
+	@.arm
 
 	__HEAD
 ENTRY(stext)
 
- THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
- THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
+ @THUMB(	adr	r9, BSYM(1f)	)	@ Kernel is always entered in ARM.
+ @THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
  THUMB(	.thumb			)	@ switch to Thumb now.
  THUMB(1:			)
 
-- 
1.7.8.3
