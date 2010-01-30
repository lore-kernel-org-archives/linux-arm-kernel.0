From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sat, 30 Jan 2010 22:07:38 +0100
Subject: [PATCH 1/3] zImage: don't hard code the stack size twice
In-Reply-To: <20100130210231.GC16345@pengutronix.de>
References: <20100130210231.GC16345@pengutronix.de>
Message-ID: <1264885660-7755-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/compressed/head.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 04bb6b4..0938d02 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -314,7 +314,7 @@ LC0:		.word	LC0			@ r1
 		.word	_start			@ r5
 		.word	_got_start		@ r6
 		.word	_got_end		@ ip
-		.word	user_stack+4096		@ sp
+		.word	user_stack_end		@ sp
 LC1:		.word	reloc_end - reloc_start
 		.size	LC0, . - LC0
 
@@ -1089,3 +1089,4 @@ reloc_end:
 		.align
 		.section ".stack", "w"
 user_stack:	.space	4096
+user_stack_end:
-- 
1.6.6
